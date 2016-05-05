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
import harbour.haveclip.network 1.0

Dialog {
    property Node node
    property bool refused: false

    id: dialog
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
    canAccept: false

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

            DialogHeader {
                acceptText: qsTr("Verify")
            }

            Label {
                anchors.margins: Theme.paddingLarge
                width: parent.width
                text: qsTr("Verification request from " + dialog.node.name)
                horizontalAlignment: Text.AlignHCenter
                color: Theme.highlightColor
                wrapMode: Text.Wrap
            }

            Label {
                id: errorLabel
                visible: false
                anchors.margins: Theme.paddingLarge
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: securityCode
                visible: !refused
                width: parent.width
                label: qsTr("Security code")
                placeholderText: qsTr("Enter the security code")
                validator: RegExpValidator {
                    regExp: /^[0-9]{6}$/
                }
                inputMethodHints: Qt.ImhDigitsOnly

                EnterKey.enabled: !errorHighlight && !refused
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: conman.provideSecurityCode(text)
            }
        }
    }

    Component.onCompleted: {
        var prompt = dialog
        var error = errorLabel

        conman.verificationFinished.connect(function(valid){
            switch(valid)
            {
            case ConnectionManager.Valid:
                prompt.canAccept = true
                prompt.accept()
                break;

            case ConnectionManager.NotValid:
                error.text = qsTr("The provided code is not valid.\nPlease try again.")
                error.visible = true
                break;

            case ConnectionManager.Refused:
                error.text = qsTr("The verification was not accepted.\nPlease repeat the process.")
                error.visible = true
                prompt.refused = true
                break;
            }


        })

        conman.verificationFailed.connect(function(status){
            error.text = qsTr("Connection error:\n" + helpers.communicationStatusToString(status))
            error.visible = true
            prompt.refused = true
        })
    }
}
