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

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: settingsPage
    allowedOrientations: Orientation.Portrait | Orientation.Landscape

    ListModel {
        id: pagesModel

        ListElement {
            page: "Clipboard.qml"
            title: "Clipboard"
        }

        ListElement {
            page: "Devices.qml"
            title: "Devices"
        }

        ListElement {
            page: "Network.qml"
            title: "Network"
        }

        ListElement {
            page: "Security.qml"
            title: "Security"
        }
    }

    RemorsePopup {
        id: remorseResetSettings
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        model: pagesModel
        header: PageHeader {
            title: qsTr("Settings")
        }
        delegate: BackgroundItem {
            width: listView.width

            Label {
                text: title
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.paddingLarge
            }

            onClicked: pageStack.push(Qt.resolvedUrl("settings/" + page))
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Reset settings")
                onClicked: {
                    remorseResetSettings.execute(qsTr("Resetting settings"), function () {
                        settings.reset()
                    }, 10000)
                }
            }
        }

        VerticalScrollDecorator {}
    }

    Component.onDestruction: settings.save()
}
