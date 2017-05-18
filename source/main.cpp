
#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char** argv) {
    QApplication app{ argc, argv };
    app.setApplicationName("stoary");
    app.setApplicationDisplayName("Stoary");
    Q_INIT_RESOURCE(qml);
    QQmlApplicationEngine engine;
    QStringList paths = {
        "C:/Qt",
        "qrc:///qml",
    #ifdef QML_IMPORT_ROOT
        QML_IMPORT_ROOT,
    #endif
    };
    engine.setImportPathList(paths);
    engine.load(QUrl{ "qrc:///qml/main.qml" });
    return app.exec();
}
