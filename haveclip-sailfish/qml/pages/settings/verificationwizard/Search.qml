/*
  HaveClip

  Copyright (C) 2013-2016 Jakub Skokan <aither@havefun.cz>

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
import harbour.haveclip.models 1.0

Dialog {
    id: dialog
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
    canAccept: !addrField.errorHighlight && !portField.errorHighlight

    acceptDestination: Qt.resolvedUrl("Verify.qml")

    onAccepted: {
        acceptDestinationInstance.host = addrField.text
        acceptDestinationInstance.port = parseInt(portField.text)

        var d = dialog

        acceptDestinationInstance.accepted.connect(function(){
            d.acceptDestination = null

            d.statusChanged.connect(function() {
                if(d.status == PageStatus.Active) {
                    d.accept()
                }
            })
        })
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
                    discoveryModel.discover()
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
                id: discoveryHeader
                text: qsTr("Auto discovery")
            }

            SilicaListView {
                id: discoveryView
                width: parent.width
                model: discoveryModel
                anchors.top: discoveryHeader.bottom

                ViewPlaceholder {
                    enabled: discoveryModel.empty
                    verticalOffset: -1 * discoveryView.y
                    text: ""
                    hintText: qsTr("Pull down to search local network")
                }

                delegate: ListItem {
                    id: delegate

                    Column {
                        x: Theme.paddingLarge

                        Label {
                            text: name
                            color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                        }

                        Label {
                            font.pixelSize: Theme.fontSizeExtraSmall
                            text: host + ":" + port
                            color: delegate.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                        }
                    }

                    onClicked: {
                        addrField.text = host
                        portField.text = port
                    }
                }
            }
        }

        VerticalScrollDecorator {}

        contentHeight: column.height
    }
}
