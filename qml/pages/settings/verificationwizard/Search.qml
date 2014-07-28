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
import harbour.haveclip.models 1.0

Dialog {
    id: dialog
    canAccept: !addrField.errorHighlight && !portField.errorHighlight

    acceptDestination: Qt.resolvedUrl("Verify.qml")

    onAccepted: {
        acceptDestinationInstance.returnPage = pageStack.previousPage(dialog)
        acceptDestinationInstance.host = addrField.text
        acceptDestinationInstance.port = parseInt(portField.text)
    }

    SilicaFlickable {
        anchors.fill: parent

        NodeDiscoveryModel {
            id: discoveryModel
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Search local network")
                onClicked: {
                    discoveryModel.discover
                }
            }
        }

        Column {
            id: column
            width: dialog.width

            DialogHeader {
                acceptText: qsTr("Verification wizard")
            }

            SectionHeader {
                text: qsTr("Enter address and port")
            }

            TextField {
                id: addrField
                width: parent.width
                label: qsTr("IP address/hostname")
                placeholderText: qsTr("IP address/hostname")
                validator: RegExpValidator {
                    regExp: /^[^\s]+$/
                }
            }

            TextField {
                id: portField
                width: parent.width
                label: qsTr("Port")
                placeholderText: qsTr("Port")
                inputMethodHints: Qt.ImhDigitsOnly
                validator: IntValidator {
                    bottom: 1
                    top: 65535
                }
            }

            SectionHeader {
                text: qsTr("Auto discovery")
            }

            SilicaListView {
                id: discoveryView
                width: parent.width
                model: NodeDiscoveryModel

                ViewPlaceholder {
                    enabled: discoveryModel.empty
                    text: ""
                    hintText: qsTr("Pull down to search local network")
                }

                delegate: ListItem {
                    id: delegate

                    Label {
                        x: Theme.paddingLarge
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                        font.capitalization: Font.Capitalize
                    }

                    Label {
                        font.pixelSize: Theme.fontSizeSmall
                        text: host + ":" + port
                    }

                    onClicked: console.log("clicked yeah")
                }
            }
        }

        VerticalScrollDecorator {}

        contentHeight: column.height
    }
}
