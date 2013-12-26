import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: settingsPage

    ListModel {
        id: pagesModel

        ListElement {
            page: "Clipboard.qml"
            title: "Clipboard"
        }

        ListElement {
            page: "Pool.qml"
            title: "Pool"
        }

        ListElement {
            page: "Connection.qml"
            title: "Connection"
        }
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

        VerticalScrollDecorator {}
    }

    Component.onDestruction: settings.save()
}
