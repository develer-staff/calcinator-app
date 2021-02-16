#include "playersmodel.h"

#include <QDataStream>
#include <QDebug>
#include <QFileInfo>
#include <QSaveFile>

#include "imagedownloader.h"
#include "imageprovider.h"

#define MAX_PLAYERS_PER_TEAM 2
#define LIST_OF_PLAYERS_FILE "list_of_players"

Q_DECLARE_METATYPE(PlayersModel::Player);

QDataStream &operator<<(QDataStream &stream, const PlayersModel::Stats &stats)
{
    stream << stats.won << stats.lost << stats.honorLost;
    return stream;
}

QDataStream &operator>>(QDataStream &stream, PlayersModel::Stats &stats)
{
    stream >> stats.won;
    stream >> stats.lost;
    stream >> stats.honorLost;
    return stream;
}

QDataStream &operator<<(QDataStream &stream, const PlayersModel::Player &player)
{
    stream << player.id << player.name << player.picture << player.stats;
    return stream;
}

QDataStream &operator>>(QDataStream &stream, PlayersModel::Player &player)
{
    stream >> player.id;
    stream >> player.name;
    stream >> player.picture;
    stream >> player.stats;
    player.team_id = PlayersModel::None;

    return stream;
}

PlayersModel *PlayersModel::instance(QObject *parent)
{
    static PlayersModel *players_model_instace = new PlayersModel(parent);
    return players_model_instace;
}

PlayersModel::PlayersModel(QObject *parent)
    : QAbstractListModel(parent)
    , updating(false)
    , teams_selection_ready(false)
{
    qRegisterMetaTypeStreamOperators<QList<Player>>("Players");

    auto &server_communicator_instance = ServerCommunicator::instance();
    connect(&server_communicator_instance, &ServerCommunicator::playersUpdated, this, &PlayersModel::updatePlayers);

    update(true);
}

int PlayersModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)

    return players.count();
}

QVariant PlayersModel::data(const QModelIndex &index, int role) const
{

    if (!index.isValid() || index.row() >= players.count())
        return QVariant();

    const auto &player = players[index.row()];

    switch (PlayerRoles(role)) {
    case PlayerRoles::Id:
        return player.id;
    case PlayerRoles::Name:
        return player.name;
    case PlayerRoles::Picture:
        return player.picture;
    case PlayerRoles::Team:
        return player.team_id;
    case PlayerRoles::Won:
        return player.stats.won;
    case PlayerRoles::Lost:
        return player.stats.lost;
    case PlayerRoles::HonorLost:
        return player.stats.honorLost;
    }

    return QVariant();
}

QHash<int, QByteArray> PlayersModel::roleNames() const
{
    return { { PlayerRoles::Id, "id" },
             { PlayerRoles::Name, "name" },
             { PlayerRoles::Picture, "picture" },
             { PlayerRoles::Team, "team" },
             { PlayerRoles::Won, "won" },
             { PlayerRoles::Lost, "lost" },
             { PlayerRoles::HonorLost, "honorLost" } };
}

bool PlayersModel::getUpdating() const
{
    return updating;
}

bool PlayersModel::getTeamsSelectionReady() const
{
    return teams_selection_ready;
}

void PlayersModel::changeTeam(QString player_id)
{
    auto i = searchPlayer(player_id);
    if (i == -1)
        return;

    auto next_team = calculateNextTeam(players[i].team_id);
    if (next_team == players[i].team_id)
        return;

    players[i].team_id = next_team;

    auto idx = index(i, 0);
    emit dataChanged(idx, idx, { PlayerRoles::Team });

    updateTeamsSelectionReady();
}

void PlayersModel::update(bool update_from_file)
{
    if (update_from_file && loadPlayersListFromFile())
        return;

    ServerCommunicator::instance().getPlayers();
}

void PlayersModel::updatePlayers(const QList<ServerCommunicator::PlayerInfo> &players)
{

    emit beginResetModel();
    setUpdating(true);

    this->players.clear();

    for (auto player : players) {
        this->players.append({ player.id,
                               player.name,
                               player.picture_url,
                               TeamId::None,
                               { player.stats.won, player.stats.lost, player.stats.honorLost } });
    }

    savePlayersListToFile();

    setUpdating(false);
    emit endResetModel();
}

void PlayersModel::setUpdating(bool uptading)
{
    if (this->updating == uptading)
        return;

    this->updating = uptading;
    emit updatingChanged();
}

int PlayersModel::searchPlayer(QString player_id) const
{
    for (int i = 0; i < players.count(); ++i) {
        if (players[i].id == player_id)
            return i;
    }

    return -1;
}

int PlayersModel::playersPerTeam(PlayersModel::TeamId team_id) const
{
    auto count = 0;
    for (const auto &player : players) {
        if (player.team_id == team_id)
            ++count;
    }

    return count;
}

PlayersModel::TeamId PlayersModel::calculateNextTeam(PlayersModel::TeamId team_id) const
{
    auto next_team = nextTeam(team_id);
    while (next_team != TeamId::None && playersPerTeam(next_team) == MAX_PLAYERS_PER_TEAM) {
        next_team = nextTeam(next_team);
    }

    return next_team;
}

PlayersModel::TeamId PlayersModel::nextTeam(PlayersModel::TeamId team_id) const
{
    return TeamId((team_id + 1) % TeamCount);
}

void PlayersModel::updateTeamsSelectionReady()
{
    auto red_team_members = 0;
    auto blue_team_members = 0;

    for (const auto &player : players) {
        if (player.team_id == Blue)
            blue_team_members++;
        else if (player.team_id == Red)
            red_team_members++;
    }

    auto selection_ready = red_team_members == MAX_PLAYERS_PER_TEAM && blue_team_members == MAX_PLAYERS_PER_TEAM;

    if (selection_ready == teams_selection_ready)
        return;

    teams_selection_ready = selection_ready;
    emit teamsSelectionReadyChanged();
}

bool PlayersModel::loadPlayersListFromFile()
{

    QFile file(LIST_OF_PLAYERS_FILE);
    if (!file.open(QSaveFile::ReadOnly))
        return false;

    setUpdating(true);

    emit beginResetModel();
    QDataStream stream(&file);
    stream >> this->players;

    emit endResetModel();
    setUpdating(false);

    return true;
}

void PlayersModel::savePlayersListToFile()
{
    QSaveFile file(LIST_OF_PLAYERS_FILE);
    file.open(QSaveFile::WriteOnly);
    file.fileName();
    QDataStream stream(&file);
    stream << this->players;

    file.commit();
}
