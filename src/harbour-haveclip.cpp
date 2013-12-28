/*
  HaveClip

  Copyright (C) 2013 Jakub Skokan <aither@havefun.cz>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <QtQuick>

#include <sailfishapp.h>
#include "../haveclip-core/src/ClipboardManager.h"
#include "qmlclipboardmanager.h"
#include "qmlsettings.h"
#include "nodemodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("HaveFun.cz");
    QCoreApplication::setOrganizationDomain("havefun.cz");
    QCoreApplication::setApplicationName("HaveClip");

    QGuiApplication *app = SailfishApp::application(argc, argv);

	qmlRegisterType<NodeModel>("HaveClip", 1, 0, "NodeModel");

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

