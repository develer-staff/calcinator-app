#include "playersmodel.h"

#include <QDebug>

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>

PlayersModel::PlayersModel(QObject *parent) : QAbstractListModel(parent) {
    auto network = new QNetworkAccessManager(this);

    connect(network, &QNetworkAccessManager::finished, this, &PlayersModel::handleReply);

    auto request = QNetworkRequest(QUrl("http://private-6fb29a-calcinator.apiary-mock.com/players"));
    network->get(request);
}

int PlayersModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent)

    return players.count();
}

QVariant PlayersModel::data(const QModelIndex &index, int role) const {

    const auto &player = players[index.row()];

    switch (PlayerRoles(role)) {
    case PlayerRoles::Id:
        return player.id;
    case PlayerRoles::Name:
        return player.name;
    case PlayerRoles::Picture:
        return player.picture;
    }

    return QVariant();
}

QHash<int, QByteArray> PlayersModel::roleNames() const {
    return {{PlayerRoles::Id, "id"},
            {PlayerRoles::Name, "name"},
            {PlayerRoles::Picture, "picture"}};
}

void PlayersModel::handleReply(QNetworkReply *reply) {
    emit beginResetModel();

    auto r = QString(reply->readAll());

    auto json = QJsonDocument::fromJson(r.toUtf8());
    qDebug() << json;

    auto json_array = json.array();
    for (auto player_data : json_array) {
        auto player_object = player_data.toObject();

        players.append({player_object["id"].toString(),
                        player_object["name"].toString(),
                        player_object["picture"].toString()});
    }
    emit endResetModel();
}
