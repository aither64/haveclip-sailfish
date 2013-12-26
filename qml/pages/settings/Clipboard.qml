import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaFlickable {
        anchors.fill: parent

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width

            PageHeader {
                title: qsTr("Clipboard settings")
            }

            SectionHeader {
                text: qsTr("History")
            }

            TextSwitch {
                id: keepHistory
                text: qsTr("Keep history")
                checked: settings.historyEnabled
                onCheckedChanged: settings.historyEnabled = checked
            }

            Slider {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                minimumValue: 1
                maximumValue: 100
                stepSize: 1
                value: settings.historySize
                enabled: keepHistory.checked
                handleVisible: enabled
                label: qsTr("History size")
                valueText: value.toString() + " " + (value == 1 ? qsTr("entry") : qsTr("entries"))
                onValueChanged: settings.historySize = value
            }

            TextSwitch {
                text: qsTr("Save history to disk")
                enabled: keepHistory.checked
                checked: settings.saveHistory
                onCheckedChanged: settings.keepHistory = checked
            }

            SectionHeader {
                text: qsTr("Synchronization")
            }

            TextSwitch {
                text: qsTr("Enable synchronization")
                checked: settings.syncEnabled
                onCheckedChanged: settings.syncEnabled = checked
            }
        }
    }
}
