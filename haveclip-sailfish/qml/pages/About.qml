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
    id: page
//    allowedOrientations: Orientation.Portrait | Orientation.Landscape

    function styledRichText(str) {
        return "<html>" +
                "<head><style type=\"text/css\">" +
                "a{color: "+ Theme.secondaryColor +";}" +
                "</style></head>" +
                "<body>" +
                str +
                "</body>" +
                "</html>"
    }

    SilicaFlickable {
        anchors.fill: parent

        Column {
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("About...")
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeLarge
                text: "HaveClip"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeSmall
                text: page.styledRichText(
                    qsTr("version v") + manager.version + " (" + qsTr("commit") + " " +
                    '<a href="https://github.com/aither64/haveclip-mobile/tree/'+ manager.commitSha1 +'">' +
                    manager.commitSha1.slice(0, 7) +'</a>)')
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Simple clipboard synchronization tool")
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeSmall
                text: page.styledRichText("<a href=\"http://www.havefun.cz/projects/haveclip/\">http://www.havefun.cz/projects/haveclip/</a>")
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }

        Column {
            width: parent.width
            spacing: Theme.paddingLarge
            y: page.height - height - 120

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text: "Developed by"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                text: page.styledRichText("Jakub Skokan &lt;<a href=\"mailto:aither@havefun.cz\">aither@havefun.cz</a>&gt;")
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text: "Icon created by"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                text: page.styledRichText("Aleš Kocur &lt;<a href=\"mailto:kafe@havefun.cz\">kafe@havefun.cz</a>&gt;")
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }
}

