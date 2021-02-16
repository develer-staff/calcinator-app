#ifndef PLAYERSMODEL_H
#define PLAYERSMODEL_H

#include <QAbstractListModel>

#include "servercommunicator.h"

class QDataStream;

class PlayersModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum TeamId {
        None,
        Red,
        Blue,
        TeamCount,
    };

    Q_ENUM(TeamId)

    enum PlayerRoles {
        Id = Qt::UserRole + 1,
        Name,
        Picture,
        Team,
        Won,
        Lost,
        HonorLost,
    };

    Q_ENUM(PlayerRoles)

    struct Stats {
        int won;
        int lost;
        int honorLost;
    };

    struct Player {
        QString id;
        QString name;
        QString picture;
        TeamId team_id;
        Stats stats;
    };

    Q_PROPERTY(bool updating READ getUpdating NOTIFY updatingChanged)
    Q_PROPERTY(bool teamsSelectionReady READ getTeamsSelectionReady NOTIFY teamsSelectionReadyChanged)

    static PlayersModel *instance(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    QHash<int, QByteArray> roleNames() const;

    bool getUpdating() const;
    bool getTeamsSelectionReady() const;

signals:
    void updatingChanged();
    void teamsSelectionReadyChanged();

public slots:
    void changeTeam(QString player_id);
    void update(bool update_from_file = false);

private slots:
    void updatePlayers(const QList<ServerCommunicator::PlayerInfo> &players);

private:
    QList<Player> players;
    bool updating;
    bool teams_selection_ready;

    explicit PlayersModel(QObject *parent = nullptr);

    void setUpdating(bool uptading);
    int searchPlayer(QString player_id) const;

    int playersPerTeam(TeamId team_id) const;
    TeamId calculateNextTeam(TeamId team_id) const;
    TeamId nextTeam(TeamId team_id) const;
    void updateTeamsSelectionReady();
    bool loadPlayersListFromFile();
    void savePlayersListToFile();
};

#endif // PLAYERSMODEL_H
