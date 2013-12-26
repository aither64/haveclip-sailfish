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
