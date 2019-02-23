#ifndef SERVERCOMMUNICATOR_H
#define SERVERCOMMUNICATOR_H

#include <QNetworkAccessManager>

class QNetworkReply;

class ServerCommunicator : public QNetworkAccessManager {
    Q_OBJECT

public:
    struct PlayerInfo {
        QString id;
        QString name;
        QString picture_url;
    };

    static ServerCommunicator *instance(QObject *parent = nullptr);

    void getPlayers();

signals:
    void playersUpdated(const QList<PlayerInfo> &players);

private:
    explicit ServerCommunicator(QObject *parent = nullptr);

    void handleReply(QNetworkReply *reply);

    static ServerCommunicator *server_communicator_instance;
};

#endif // SERVERCOMMUNICATOR_H
