#include "accessamanagerfactory.h"

#include <QAbstractNetworkCache>
#include <QDataStream>
#include <QDebug>
#include <QFile>
#include <QNetworkAccessManager>
#include <QNetworkDiskCache>

#include "servercommunicator.h"

#define ACCESS_MANAGER_CACHE "access_manager_cache"

CalcinatorAccessManager::CalcinatorAccessManager(QObject *parent)
    : QNetworkAccessManager(parent)
{
    auto cache = new QNetworkDiskCache(this);
    cache->setCacheDirectory(ACCESS_MANAGER_CACHE);
    setCache(cache);
}

QNetworkReply *CalcinatorAccessManager::createRequest(QNetworkAccessManager::Operation op,
                                                      const QNetworkRequest &originalReq, QIODevice *outgoingData)
{
    QNetworkRequest req(originalReq);
    req.setAttribute(QNetworkRequest::CacheLoadControlAttribute, QNetworkRequest::PreferNetwork);
    return QNetworkAccessManager::createRequest(op, req, outgoingData);
}

AccessaManagerFactory::AccessaManagerFactory()
    : QQmlNetworkAccessManagerFactory()
{
}

QNetworkAccessManager *AccessaManagerFactory::create(QObject *parent)
{
    return new CalcinatorAccessManager(parent);
}
