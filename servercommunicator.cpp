#include "servercommunicator.h"

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>

ServerCommunicator::ServerCommunicator(QObject *parent)
    : QNetworkAccessManager(parent)
{
    connect(this, &ServerCommunicator::finished, this, &ServerCommunicator::handleReply);
}

ServerCommunicator &ServerCommunicator::instance()
{
    static ServerCommunicator server_communicator_instance;
    return server_communicator_instance;
}

void ServerCommunicator::getPlayers()
{
    auto request = QNetworkRequest(QUrl("http://private-6fb29a-calcinator.apiary-mock.com/players"));
    get(request);
}

void ServerCommunicator::handleReply(QNetworkReply *reply)
{
    QList<PlayerInfo> players;

    auto r = QString(reply->readAll());

    auto json = QJsonDocument::fromJson(r.toUtf8());
    qDebug() << json;

    auto json_array = json.array();
    for (auto player_data : json_array) {
        auto player_object = player_data.toObject();

        players.append({ player_object["id"].toString(), player_object["name"].toString(),
                         player_object["picture"].toString() });
    }

    emit playersUpdated(players);
}
