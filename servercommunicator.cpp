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

    auto json = QJsonDocument::fromJson(reply->readAll());
    qDebug() << json;

    auto json_array = json.array();
    for (auto player_data : json_array) {
        auto player_object = player_data.toObject();
        auto player_stats = player_object["stats"].toObject();

        Stats stats { player_stats["won"].toInt(), player_stats["lost"].toInt(), player_stats["honorLost"].toInt() };

        players.append({ player_object["id"].toString(), player_object["name"].toString(),
                         player_object["picture"].toString(), stats });
    }

    emit playersUpdated(players);
}
