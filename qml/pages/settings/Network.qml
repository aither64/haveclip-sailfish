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

        VerticalScrollDecorator {
            flickable: parent
        }

        Column {
            id: column
            width: parent.width

            PageHeader {
                title: qsTr("Network")
            }

            SectionHeader {
                text: qsTr("Listen on")
            }

            TextField {
                id: host
                width: parent.width
                label: qsTr("IP address or hostname")
                placeholderText: qsTr("IP address or hostname")
                text: settings.host
                validator: RegExpValidator {
                    regExp: /^[^\s]+$/
                }
            }

            Binding {
                target: settings
                property: "host"
                value: host.text
            }

            TextField {
                id: port
                width: parent.width
                label: qsTr("Port")
                placeholderText: qsTr("Port")
                text: settings.port
                inputMethodHints: Qt.ImhDigitsOnly
                validator: IntValidator {
                    bottom: 1024
                    top: 65535
                }
            }

            Binding {
                target: settings
                property: "port"
                value: parseInt(port.text)
            }

            SectionHeader {
                text: qsTr("Auto discovery")
            }

            TextSwitch {
                id: allowAutoDiscovery
                text: qsTr("Allow this device to be auto-discovered in LAN")
                checked: settings.allowAutoDiscovery
            }

            Binding {
                target: settings
                property: "allowAutoDiscovery"
                value: allowAutoDiscovery.checked
            }

            TextField {
                id: networkName
                width: parent.width
                label: qsTr("Network name")
                placeholderText: qsTr("network name")
                text: settings.networkName
            }

            Binding {
                target: settings
                property: "networkName"
                value: networkName.text
            }

            SectionHeader {
                text: qsTr("Limits")
            }

            Slider {
                id: maxSendSize
                width: parent.width
                label: qsTr("Max clipboard size to send")
                value: settings.maxSendSize / 1024 / 1024
                minimumValue: 0
                maximumValue: 1000
                stepSize: 5
                valueText: value + " MB"
            }

            Binding {
                target: settings
                property: "maxSendSize"
                value: maxSendSize.value * 1024 * 1024
            }

            Slider {
                id: maxRecvSize
                width: parent.width
                label: qsTr("Max clipboard size to receive")
                value: settings.maxReceiveSize / 1024 / 1024
                minimumValue: 0
                maximumValue: 1000
                stepSize: 5
                valueText: value + " MB"
            }

            Binding {
                target: settings
                property: "maxReceiveSize"
                value: maxRecvSize.value * 1024 * 1024
            }
        }
    }
}
