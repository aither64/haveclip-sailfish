import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
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
                onClicked: settings.deleteAllNodes();
            }

            MenuItem {
                text: qsTr("Add node")
                onClicked: {
                    var dialog = pageStack.push("NodeDialog.qml", {"headerText": qsTr("Add node")})

                    dialog.accepted.connect(function() {
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
                        onClicked: settings.deleteNodeAt(model.index)
                    }
                }
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
                    else
                        settings.updateNodeAt(model.index, dialog.addr, dialog.port)
                })
            }
        }
    }
}
