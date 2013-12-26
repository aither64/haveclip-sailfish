import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

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
                font.pixelSize: Theme.fontSizeSmall
                text: qsTr("version v") + "0.11.0"
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
                text: "Developed by"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeSmall
                text: page.styledRichText("Jakub Skokan &lt;<a href=\"mailto:aither@havefun.cz\">aither@havefun.cz</a>&gt;")
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Icon created by"
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeSmall
                text: page.styledRichText("Aleš Kocur &lt;<a href=\"mailto:kafe@havefun.cz\">kafe@havefun.cz</a>&gt;")
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }
}

