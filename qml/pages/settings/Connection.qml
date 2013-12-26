import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: column
            width: parent.width

            PageHeader {
                title: qsTr("Connection")
            }

            SectionHeader {
                text: qsTr("Listen on")
            }

            TextField {
                width: parent.width
                label: qsTr("IP address or hostname")
                placeholderText: qsTr("IP address or hostname")
                text: settings.host
                onTextChanged: settings.host = text
            }

            TextField {
                width: parent.width
                label: qsTr("Port")
                placeholderText: qsTr("Port")
                text: settings.port
                inputMethodHints: Qt.ImhDigitsOnly
                onTextChanged: settings.port = parseInt(text)
            }

            SectionHeader {
                text: qsTr("Access policy")
            }

            TextField {
                width: parent.width
                label: qsTr("Password")
                placeholderText: qsTr("Password")
                text: settings.password
                onTextChanged: settings.password = text
            }
        }
    }
}
