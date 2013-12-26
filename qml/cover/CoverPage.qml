import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Label {
        text: "HaveClip"
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 4
    }

    Label {
        text: manager.content.trim().slice(0, 15)
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.verticalCenter
        }
        font.pixelSize: Theme.fontSizeExtraSmall
    }

    CoverActionList {
        enabled: settings.syncEnabled

        CoverAction {
            iconSource: "image://theme/icon-cover-pause"
            onTriggered: settings.syncEnabled = false
        }
    }

    CoverActionList {
        enabled: !settings.syncEnabled

        CoverAction {
            iconSource: "image://theme/icon-cover-play"
            onTriggered: settings.syncEnabled = true
        }
    }
}


