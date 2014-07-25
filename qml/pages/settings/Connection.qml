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
                validator: RegExpValidator {
                    regExp: /^[^\s]+$/
                }
                onTextChanged: settings.host = text
            }

            TextField {
                width: parent.width
                label: qsTr("Port")
                placeholderText: qsTr("Port")
                text: settings.port
                inputMethodHints: Qt.ImhDigitsOnly
                validator: IntValidator {
                    bottom: 1024
                    top: 65535
                }
                onTextChanged: settings.port = parseInt(text)
            }
        }
    }
}
