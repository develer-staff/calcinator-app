#ifndef SERVERCOMMUNICATOR_H
#define SERVERCOMMUNICATOR_H

#include <QNetworkAccessManager>

class QNetworkReply;

class ServerCommunicator : public QNetworkAccessManager
{
    Q_OBJECT

public:
    struct Stats {
        int won;
        int lost;
        int honorLost;
    };

    struct PlayerInfo {
        QString id;
        QString name;
        QString picture_url;
        Stats stats;
    };

    static ServerCommunicator &instance();

    void getPlayers();

signals:
    void playersUpdated(const QList<PlayerInfo> &players);

private:
    explicit ServerCommunicator(QObject *parent = nullptr);

    void handleReply(QNetworkReply *reply);
};

#endif // SERVERCOMMUNICATOR_H
