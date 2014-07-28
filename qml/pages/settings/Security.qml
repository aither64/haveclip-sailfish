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

        Column {
            id: column
            width: parent.width

            PageHeader {
                title: qsTr("Security")
            }

            SectionHeader {
                text: qsTr("Encryption")
            }

            ComboBox {
                id: mode
                width: parent.width
                label: "Mode"

                menu: ContextMenu {
                    MenuItem { text: "None" }
                    MenuItem { text: "SSL" }
                    MenuItem { text: "TLS" }
                }

                currentIndex: settings.encryption
            }

            Binding {
                target: settings
                property: "encryption"
                value: mode.currentIndex
            }

            TextField {
                id: certificate
                width: parent.width
                label: qsTr("Certificate path")
                placeholderText: qsTr("certificate path")
                text: settings.certificatePath
            }

            Binding {
                target: settings
                property: "certificatePath"
                value: certificate.text
            }

            TextField {
                id: privateKey
                width: parent.width
                label: qsTr("Private key")
                placeholderText: qsTr("Private key")
                text: settings.privateKeyPath
            }

            Binding {
                target: settings
                property: "privateKeyPath"
                value: privateKey.text
            }
        }
    }
}
