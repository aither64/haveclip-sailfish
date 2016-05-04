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
    allowedOrientations: Orientation.Portrait | Orientation.Landscape

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width

            PullDownMenu {
                id: pullDownMenu

                MenuItem {
                    text: qsTr("Generate new certificate")
                    onClicked: {
                        pageStack.push("security/CertificateGenerator.qml")
                    }
                }
            }

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

            SectionHeader {
                text: qsTr("Identity")
            }

            Column {
                width: parent.width
                visible: helpers.selfSslCertificate.null

                Label {
                    width: parent.width
                    color: Theme.highlightColor
                    text: qsTr("The certificate is not valid.")
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Column {
                width: parent.width
                visible: !helpers.selfSslCertificate.null

                ValueButton {
                    width: parent.width
                    label: qsTr("Common name")
                    value: helpers.selfSslCertificate.commonName
                    enabled: false
                }

                ValueButton {
                    width: parent.width
                    label: qsTr("Organization")
                    value: helpers.selfSslCertificate.organization
                    enabled: false
                }

                ValueButton {
                    width: parent.width
                    label: qsTr("Organization unit")
                    value: helpers.selfSslCertificate.organizationUnit
                    enabled: false
                }

                ValueButton {
                    width: parent.width
                    label: qsTr("Issued on")
                    value: Qt.formatDateTime(helpers.selfSslCertificate.issuedOn, "d/M/yyyy")
                    enabled: false
                }

                ValueButton {
                    width: parent.width
                    label: qsTr("Expires on")
                    value: Qt.formatDateTime(helpers.selfSslCertificate.expiryDate, "d/M/yyyy")
                    enabled: false
                }

                ValueButton {
                    width: parent.width
                    label: qsTr("Organization")
                    value: helpers.selfSslCertificate.organization
                    enabled: false
                }

                ValueButton {
                    width: parent.width
                    label: qsTr("SHA-1 Fingerprint")
                    value: helpers.selfSslCertificate.sha1Digest
                    enabled: false
                }
            }
        }
    }
}
