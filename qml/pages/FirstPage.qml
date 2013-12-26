import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaListView {
        id: listView
        model: historyModel
        anchors.fill: parent
        header: PageHeader {
            id: pageHeader
            title: qsTr("Clipboard history")
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("About...")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }

            MenuItem {
                text: qsTr("Clear history")
                onClicked: historyModel.clear()
            }

            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
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
                text: formatItem(display)
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
                            var idx = index
                            var model = historyModel
                            remorse.execute(delegate, qsTr("Deleting"), function() {
                                model.remove(idx)
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


