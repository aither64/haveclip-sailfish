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
            }

            Binding {
                target: settings
                property: "historyEnabled"
                value: keepHistory.checked
            }

            Slider {
                id: historySize
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
            }

            Binding {
                target: settings
                property: "historySize"
                value: historySize.value
            }

            TextSwitch {
                id: saveHistory
                text: qsTr("Save history to disk")
                enabled: keepHistory.checked
                checked: settings.saveHistory
            }

            Binding {
                target: settings
                property: "saveHistory"
                value: saveHistory.checked
            }


            SectionHeader {
                text: qsTr("Synchronization")
            }

            TextSwitch {
                id: syncEnabled
                text: qsTr("Enable synchronization")
                checked: settings.syncEnabled
            }

            Binding {
                target: settings
                property: "syncEnabled"
                value: syncEnabled.checked
            }

//            TextSwitch {
//                id: sendEnabled
//                text: qsTr("Enable clipboard sending")
//                checked: settings.sendEnabled
//                enabled: syncEnabled.checked
//            }

//            Binding {
//                target: settings
//                property: "sendEnabled"
//                value: sendEnabled.checked
//            }

//            TextSwitch {
//                id: recvEnabled
//                text: qsTr("Enable clipboard receiving")
//                checked: settings.recvEnabled
//                enabled: syncEnabled.checked
//            }

//            Binding {
//                target: settings
//                property: "recvEnabled"
//                value: recvEnabled.checked
//            }
        }
    }
}
