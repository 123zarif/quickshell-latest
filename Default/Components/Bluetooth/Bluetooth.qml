import "../"

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth


Rectangle {
    property bool bluetoothHover: false
        property bool widgetHover: false
            property bool showWidget: false
                property var connectedDevices: Bluetooth?.defaultAdapter?.devices?.values?.filter(device => device.connected)


                id: bluetooth
                Layout.preferredWidth: row.width + 20
                Layout.fillHeight: true

                color: secondary
                radius: 100
                bottomRightRadius: showWidget ? 0 : 100
                bottomLeftRadius: showWidget ? 0 : 100

                Timer {
                    id: graceTimer
                    interval: 200
                    running: false
                    repeat: false
                    onTriggered: {
                        if (!Bluetooth?.defaultAdapter?.enabled)
                        {
                            showWidget = false
                            return;
                        }

                        Bluetooth.defaultAdapter.pairable = true
                        showWidget = bluetoothHover || widgetHover
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        bluetoothHover = true
                        graceTimer.running = true
                    }
                    onExited: {
                        bluetoothHover = false
                        graceTimer.running = true
                    }
                }

                RowLayout {
                    id: row
                    height: parent.height
                    anchors.centerIn: parent

                    Bluetooth_Settings_Widget {
                    anchorTo: bluetooth
                }

                Icons {
                    name: Bluetooth?.defaultAdapter?.enabled ? "network-bluetooth" : "network-bluetooth-inactive"
                    iconColor: primary
                }

                Text {
                    text: connectedDevices && connectedDevices.length > 0 ? `${connectedDevices[0]?.name.toUpperCase()} (${connectedDevices[0]?.batteryAvailable ? connectedDevices[0]?.battery * 100 : '0'}%)` : ''
                    color: primary
                    font.pixelSize: 14
                    font.weight: Font.Bold
                    visible: Bluetooth?.defaultAdapter?.enabled ? connectedDevices ? connectedDevices?.length > 0 : false : false
                }

            }
        }

