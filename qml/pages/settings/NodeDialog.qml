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
import harbour.haveclip.core 1.0

Dialog {
    property Node node
    property bool shouldDelete: false
    property bool isOk: false

    id: dialog
    canAccept: !nameField.errorHighlight && !addrField.errorHighlight && !portField.errorHighlight

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator {
            flickable: parent
        }

        PullDownMenu {
            id: menu

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
                acceptText: qsTr("Edit node")
            }

            SectionHeader {
                text: qsTr("Description")
            }

            TextField {
                id: nameField
                width: parent.width
                label: qsTr("Name")
                placeholderText: qsTr("Name")
                text: node.name
                validator: RegExpValidator {
                    regExp: /.+/
                }
            }

            Binding {
                target: node
                property: "name"
                value: nameField.text
            }

            TextField {
                id: addrField
                width: parent.width
                label: qsTr("IP address/hostname")
                placeholderText: qsTr("IP address/hostname")
                text: node.host
                validator: RegExpValidator {
                    regExp: /^[^\s]+$/
                }
            }

            Binding {
                target: node
                property: "host"
                value: addrField.text
            }

            TextField {
                id: portField
                width: parent.width
                label: qsTr("Port")
                placeholderText: qsTr("Port")
                text: node.port
                inputMethodHints: Qt.ImhDigitsOnly
                validator: IntValidator {
                    bottom: 1
                    top: 65535
                }
            }

            Binding {
                target: node
                property: "port"
                value: portField.text
            }
        }
    }

    onDone: {

    }
}
