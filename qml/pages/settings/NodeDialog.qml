import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property string addr
    property string port
    property string headerText
    property bool canDelete: false
    property bool shouldDelete: false
    property int index

    id: dialog

    SilicaFlickable {
        anchors.fill: parent

        Component.onCompleted: {
            if(!canDelete)
                menu.destroy()
        }

        PullDownMenu {
            id: menu
            visible: canDelete

            MenuItem {
                text: qsTr("Delete")
                onClicked: {
                    shouldDelete = true
                    dialog.accept()
                }
            }
        }

        Column {
            id: column
            width: dialog.width

            DialogHeader {
                acceptText: headerText
            }

            TextField {
                id: addrField
                width: parent.width
                label: qsTr("IP address/hostname")
                placeholderText: qsTr("IP address/hostname")
                text: addr
            }

            TextField {
                id: portField
                width: parent.width
                label: qsTr("Port")
                placeholderText: qsTr("Port")
                text: port
                inputMethodHints: Qt.ImhDigitsOnly
            }
        }

        contentHeight: column.height
    }

    onDone: {
        if(result == DialogResult.Accepted) {
            addr = addrField.text
            port = portField.text
        }
    }
}
