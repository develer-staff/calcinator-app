#ifndef PLAYERSMODEL_H
#define PLAYERSMODEL_H

#include <QAbstractListModel>

#include "servercommunicator.h"

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
    };

    Q_ENUM(PlayerRoles)

    explicit PlayersModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    QHash<int, QByteArray> roleNames() const;

public slots:
    void changeTeam(QString player_id);

private slots:
    void updatePlayers(const QList<ServerCommunicator::PlayerInfo> &players);

private:
    struct Player {
        QString id;
        QString name;
        QString picture;
        TeamId team_id;
    };

    QList<Player> players;

    int searchPlayer(QString player_id) const;
};

#endif // PLAYERSMODEL_H
