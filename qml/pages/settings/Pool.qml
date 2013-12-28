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
    RemorsePopup {
        id: remorseDelete
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        model: settings.nodeModel
        header: PageHeader {
            id: pageHeader
            title: qsTr("Pool")
        }

        ViewPlaceholder {
            enabled: listView.count == 0
            text: qsTr("Pool is empty")
            hintText: qsTr("Pull down to add nodes")
        }

        PullDownMenu {
            id: pullDownMenu

            MenuItem {
                text: qsTr("Delete all")
                onClicked: {
                    var s = settings
                    remorseDelete.execute(qsTr("Deleting all nodes"), function() {
                        s.deleteAllNodes()
                    })
                }
            }

            MenuItem {
                text: qsTr("Add node")
                onClicked: {
                    var dialog = pageStack.push("NodeDialog.qml", {"headerText": qsTr("Add node")})

                    dialog.accepted.connect(function() {
                        if(dialog.isOk)
                            settings.addNode(dialog.addr, dialog.port)
                    })
                }
            }
        }

        VerticalScrollDecorator {}

        delegate: ListItem {
            id: listItem
            menu: contextMenuComponent

            Label {
                x: Theme.paddingLarge
                text: display
                anchors.verticalCenter: parent.verticalCenter
                font.capitalization: Font.Capitalize
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }

            Component {
                id: contextMenuComponent

                ContextMenu {
                    MenuItem {
                        text: qsTr("Delete")
                        onClicked: {
                            var idx = index
                            var s = settings
                            remorseItem.execute(listItem, qsTr("Deleting node"), function() {
                                s.deleteNodeAt(idx)
                            })
                        }
                    }
                }
            }

            RemorseItem {
                id: remorseItem
            }

            onClicked: {
                var node = display.split(":")
                var dialog = pageStack.push("NodeDialog.qml", {
                    "headerText": qsTr("Edit node"),
                    "index": model.index,
                    "canDelete": true,
                    "addr": node[0],
                    "port": node[1]
                })

                dialog.accepted.connect(function() {
                    if(dialog.shouldDelete)
                        settings.deleteNodeAt(model.index)
                    else if(dialog.isOk)
                        settings.updateNodeAt(model.index, dialog.addr, dialog.port)
                })
            }
        }
    }
}
