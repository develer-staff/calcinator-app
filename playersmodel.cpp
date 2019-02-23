#include "playersmodel.h"

#include <QDebug>

PlayersModel::PlayersModel(QObject *parent)
    : QAbstractListModel(parent)
{
    auto &server_communicator_instance = ServerCommunicator::instance();
    connect(&server_communicator_instance, &ServerCommunicator::playersUpdated, this, &PlayersModel::updatePlayers);

    ServerCommunicator::instance().getPlayers();
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
    }

    return QVariant();
}

QHash<int, QByteArray> PlayersModel::roleNames() const
{
    return { { PlayerRoles::Id, "id" },
             { PlayerRoles::Name, "name" },
             { PlayerRoles::Picture, "picture" },
             { PlayerRoles::Team, "team" } };
}

void PlayersModel::changeTeam(QString player_id)
{
    auto i = searchPlayer(player_id);
    if (i == -1)
        return;

    players[i].team_id = TeamId((players[i].team_id + 1) % TeamCount);

    auto idx = index(i, 0);
    emit dataChanged(idx, idx, { PlayerRoles::Team });
}

void PlayersModel::updatePlayers(const QList<ServerCommunicator::PlayerInfo> &players)
{

    emit beginResetModel();

    for (auto player : players) {
        this->players.append({ player.id, player.name, player.picture_url, TeamId::None });
    }
    emit endResetModel();
}

int PlayersModel::searchPlayer(QString player_id) const
{
    for (int i = 0; i < players.count(); ++i) {
        if (players[i].id == player_id)
            return i;
    }

    return -1;
}
