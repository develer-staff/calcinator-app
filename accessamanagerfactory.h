#ifndef ACCESSAMANAGERFACTORY_H
#define ACCESSAMANAGERFACTORY_H

#include <QNetworkAccessManager>
#include <QQmlNetworkAccessManagerFactory>

class CalcinatorAccessManager : public QNetworkAccessManager
{
public:
    CalcinatorAccessManager(QObject *parent = nullptr);

    QNetworkReply *createRequest(QNetworkAccessManager::Operation op, const QNetworkRequest &originalReq,
                                 QIODevice *outgoingData = nullptr) override;
};

class AccessaManagerFactory : public QQmlNetworkAccessManagerFactory
{
public:
    AccessaManagerFactory();

    QNetworkAccessManager *create(QObject *parent = nullptr) override;
};

#endif // ACCESSAMANAGERFACTORY_H
