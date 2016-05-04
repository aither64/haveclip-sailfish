/*
  HaveClip

  Copyright (C) 2013-2016 Jakub Skokan <aither@havefun.cz>

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
    id: page
    allowedOrientations: Orientation.Portrait | Orientation.Landscape

    Timer {
        id: initTimer
        repeat: false
        interval: 300

        onTriggered: pageStack.push(Qt.resolvedUrl("settings/security/CertificateGenerator.qml"))
    }

    Component.onCompleted: {
        if (settings.firstStart) {
            initTimer.start()
        }
    }

    RemorsePopup {
        id: remorseHistory
    }

    SilicaListView {
        id: listView
        model: historyModel
        anchors.fill: parent
        header: PageHeader {
            id: pageHeader
            title: qsTr("Clipboard history")
        }

        ViewPlaceholder {
            enabled: listView.count == 0
            text: qsTr("History is empty")
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("About...")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }

            MenuItem {
                text: qsTr("Clear history")
                onClicked: {
                    var model = historyModel

                    remorseHistory.execute(qsTr("Clearing history"), function () {
                        model.clear()
                    })
                }
            }

            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
            }

            MenuItem {
                text: qsTr("Synchronize clipboard")
                onClicked: manager.doSync()
            }
        }

        delegate: ListItem {
            id: delegate
            menu: contextMenuComponent

            function formatItem(str) {
                var ret = str.trim().slice(0, 30);

                if(str.length > 30)
                    ret += "...";

                else if(!str.length)
                    ret = "<empty>";

                return ret;
            }

            Label {
                x: Theme.paddingLarge
                text: formatItem(plaintext)
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }

            Component {
                id: contextMenuComponent

                ContextMenu {
//                    MenuItem {
//                        text: qsTr("Edit")
//                    }

                    MenuItem {
                        text: qsTr("Delete")
                        onClicked: {
                            var p = pointer
                            var model = historyModel

                            remorse.execute(delegate, qsTr("Deleting"), function() {
                                model.remove(p)
                            })
                        }
                    }
                }
            }

            RemorseItem {
                id: remorse
            }

            onClicked: manager.jumpToItemAt(index)
        }

        VerticalScrollDecorator {}
    }
}


