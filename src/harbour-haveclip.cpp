#include <QtQuick>

#include <sailfishapp.h>
#include "../haveclip-core/src/ClipboardManager.h"
#include "qmlclipboardmanager.h"
#include "qmlsettings.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("HaveFun.cz");
    QCoreApplication::setOrganizationDomain("havefun.cz");
    QCoreApplication::setApplicationName("HaveClip");

    QGuiApplication *app = SailfishApp::application(argc, argv);

    ClipboardManager manager;
	manager.delayedStart(500);

    QmlSettings settings;
    QmlClipboardManager qmlManager;

    QQuickView *view = SailfishApp::createView();
    QQmlContext *context = view->engine()->rootContext();

    context->setContextProperty("settings", &settings);
    context->setContextProperty("manager", &qmlManager);
	context->setContextProperty("historyModel", manager.history());

	view->setSource(SailfishApp::pathTo("qml/harbour-haveclip.qml"));
    view->show();

    return app->exec();
}

