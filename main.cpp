#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "playersmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterSingletonType<PlayersModel>("players", 1, 0, "PlayersModel",
                                           [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
                                               Q_UNUSED(scriptEngine)
                                               return PlayersModel::instance(engine);
                                           });

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:///");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
