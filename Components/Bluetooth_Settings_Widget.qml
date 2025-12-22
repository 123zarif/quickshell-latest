import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Bluetooth

PopupWindow {
    property var anchorTo: null
        property var player: null

            id: bluetoothSettingsPopup
            anchor.window: root

            anchor.rect.x: 0
            anchor.rect.y: root.height - 10

            implicitWidth: 500
            implicitHeight: 400
            visible: showWidget || rect.opacity > 0
            color: "transparent"

            Timer {
                interval: 50
                running: true
                repeat: false
                onTriggered: {
                    let pos = anchorTo.mapToItem(root.contentItem, 0, 0)
                    bluetoothSettingsPopup.anchor.rect.x = pos.x - 500 + anchorTo.width

                }
            }

            Timer {
                interval: 10000
                running: showWidget && Bluetooth?.defaultAdapter && Bluetooth?.defaultAdapter?.enabled && !Bluetooth?.defaultAdapter?.discovering
                repeat: true
                onTriggered: {
                    Bluetooth.defaultAdapter.discovering = true
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    widgetHover = true
                    graceTimer.running = true
                }
                onExited: {
                    widgetHover = false
                    graceTimer.running = true
                }
            }


            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                Rectangle {
                    color: secondary
                    Layout.preferredWidth: anchorTo.width
                    Layout.preferredHeight: 5
                    Layout.alignment: Qt.AlignRight
                    opacity: showWidget ? 1 : 0

                    Behavior on opacity {
                    NumberAnimation {
                        duration: 400
                        easing.type: Easing.InOutQuad
                    }
                }
            }


            Rectangle {
                id: rect
                opacity: showWidget ? 1 : 0
                radius: 10
                topRightRadius: 0
                color: secondary
                Layout.fillWidth: true
                Layout.fillHeight: true

                Behavior on opacity {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutQuad
                }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20
                Text {
                    text: "Bluetooth Settings"
                    color: primary
                    font.pixelSize: 28
                    font.weight: Font.Bold
                    Layout.alignment: Qt.AlignHCenter
                }

                ListView {
                    id: deviceList
                    model: Bluetooth?.defaultAdapter?.devices?.values ?? []
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 25

                    delegate: RowLayout {
                        width: deviceList.width
                        spacing: 10

                        Rectangle {
                            Layout.preferredWidth: removeIcon.width + 15
                            Layout.preferredHeight: removeIcon.height + 15
                            color: '#ff0000'
                            radius: 100
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    modelData.forget()
                                }
                            }
                            Icons {
                                id: removeIcon
                                name: "user-trash"
                                iconColor: '#fff'
                                size: 15
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Text {
                            text: modelData.name.toUpperCase()
                            color: primary
                            font.pixelSize: 20
                            font.weight: Font.Bold
                            Layout.fillWidth: true

                        }

                        Rectangle {
                            Layout.preferredWidth: connectButtonText.width + 20
                            Layout.preferredHeight: connectButtonText.height + 10
                            radius: 100
                            color: primary

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    if (modelData.pairing)
                                    {
                                        modelData.cancelPairing();
                                        return;
                                    }
                                    if (modelData.bonded)
                                    {
                                        if (modelData.connected)
                                        {
                                            modelData.disconnect()
                                        }
                                        else {
                                            modelData.connect()
                                        }
                                    }
                                    else {
                                        if (Bluetooth.defaultAdapter.pairable)
                                        {
                                            modelData.pair()
                                        }
                                    }
                                }
                            }

                            Text {
                                id: connectButtonText
                                text: modelData.pairing ? "Pairing" : modelData.bonded ? modelData.connected ? "Disconnect" : "Connect" : Bluetooth.defaultAdapter.pairable ? "Pair" : "Unavailable"
                                color: secondary
                                font.pixelSize: 16
                                anchors.centerIn: parent
                            }
                        }
                    }
                }
            }
        }

    }
}