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

Dialog {
    property string addr
    property string port
    property string headerText
    property bool canDelete: false
    property bool shouldDelete: false
    property int index

    id: dialog

    SilicaFlickable {
        anchors.fill: parent

        Component.onCompleted: {
            if(!canDelete)
                menu.destroy()
        }

        PullDownMenu {
            id: menu
            visible: canDelete

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
                acceptText: headerText
            }

            TextField {
                id: addrField
                width: parent.width
                label: qsTr("IP address/hostname")
                placeholderText: qsTr("IP address/hostname")
                text: addr
            }

            TextField {
                id: portField
                width: parent.width
                label: qsTr("Port")
                placeholderText: qsTr("Port")
                text: port
                inputMethodHints: Qt.ImhDigitsOnly
            }
        }

        contentHeight: column.height
    }

    onDone: {
        if(result == DialogResult.Accepted) {
            addr = addrField.text
            port = portField.text
        }
    }
}
