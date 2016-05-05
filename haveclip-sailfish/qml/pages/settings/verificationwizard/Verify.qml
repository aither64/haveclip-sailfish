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
import harbour.haveclip.network 1.0

Dialog {
    property string host
    property int port
    property int nodeId: 0
    property bool introduced: false
    property bool error: false

    id: dialog
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
    canAccept: false

    SilicaFlickable {
        anchors.fill: parent

        BusyIndicator {
            anchors.centerIn: parent
            running: !dialog.introduced && !error
            size: BusyIndicatorSize.Large
        }

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }

            DialogHeader {
                id: header
                acceptText: dialog.introduced ? qsTr("Verification code") : qsTr("Connecting...")
            }

            Label {
                visible: dialog.introduced
                width: parent.width
                anchors.margins: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                text: qsTr(
                          "Please go to "
                          + helpers.verifiedNode().name
                          + " and type in the security code shown below."
                    )
                wrapMode: Text.Wrap
            }
        }

        Label {
            id: errorLabel
            width: parent.width
            anchors.margins: Theme.paddingLarge
            visible: false
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
            wrapMode: Text.Wrap
        }

        Label {
            visible: dialog.introduced && !dialog.error
            anchors.centerIn: parent
            font.pixelSize: Theme.fontSizeLarge
            text: qsTr("Security code:") + " " + conman.securityCode
        }
    }

    onOpened:  {
        var d = dialog

        conman.introductionFinished.connect(function(){
            d.introduced = true

            // refresh node name shown in the label above
            helpers.verifiedNode()
        })

        conman.introductionFailed.connect(function(status){
            d.error = true
            errorLabel.text = "Error occured:\n" + helpers.communicationStatusToString(status)
            errorLabel.visible = true
        })

        conman.verificationFinished.connect(function(status){
            switch(status) {
            case ConnectionManager.Valid:
                d.canAccept = true
                d.accept()

            case ConnectionManager.NotValid:
                break;

            case ConnectionManager.Refused:
                d.error = true
                errorLabel.text = qsTr("You have run out of tries. Please repeat the verification process.")
                errorLabel.visible = true
                break;
            }
        })

        dialog.introduced = false

        if(nodeId > 0)
            conman.verifyConnection(nodeId)
        else
            conman.verifyConnection(host, port)

        console.log("host = " + host, ", port = ", port, ", node id = ", nodeId)
    }
}
