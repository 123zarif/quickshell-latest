import "./Components"
import "./Components/Media"
import "./Components/Bluetooth"
import "./Components/Sound"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland


PanelWindow {
    required property var modelData
    screen: modelData

    id: root
    implicitHeight: 50

    color: "transparent"


    anchors {
        top: true
        left: true
        right: true
    }

    property double memUsed: 0.1
        property double memTotal: 1.1
            property int memPercent: 0

                property int lastCpuIdle: 0
                    property int lastCpuTotal: 1
                        property int cpuPercent: 0


                            property bool systemWidgetVisible: false



                                Process {
                                    id: memProcess
                                    command: ["sh", "-c", "free | grep Mem" ]
                                    stdout: SplitParser {
                                        onRead: data => {
                                        var parts = data.trim().split(/\s+/);
                                        var total = parseInt(parts[1]) || 1;
                                        var used = parseInt(parts[2]) || 1;

                                        var totalGib = (total / 1024 / 1024).toFixed(1);
                                        var usedGib = (used / 1024 / 1024).toFixed(1);
                                        var percentUsed = Math.round(((used / total) * 100));

                                        memTotal = totalGib;
                                        memUsed = usedGib;
                                        memPercent = percentUsed;
                                    }
                                }

                            }

                            Process {
                                id: cpuProcess
                                command: ["sh", "-c", "grep '^cpu ' /proc/stat" ]
                                stdout: SplitParser {
                                    onRead: data => {
                                    var parts = data.trim().split(/\s+/);
                                    var idle = parseInt(parts[4]) + parseInt(parts[5]);
                                    const total = parts.slice(1).reduce((acc, val) => acc + parseInt(val), 0);

                                    if (lastCpuTotal > 0)
                                    {
                                        cpuPercent = (100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal))).toFixed(2);

                                    }

                                    lastCpuIdle = idle;
                                    lastCpuTotal = total;
                                }
                            }

                        }

                        Timer {
                            interval: 3000
                            running: true
                            repeat: true
                            onTriggered: {
                                memProcess.running = true
                                cpuProcess.running = true
                            }
                        }


                        GlobalShortcut {
                            name: "system_widget"
                            description: "Toggles the system widget"
                            onPressed: {
                                systemWidgetVisible = !systemWidgetVisible
                            }
                        }




                        Item {
                            id: widgets
                            LazyLoader {
                                loading: false
                                active: systemWidgetVisible
                                System_Widgets {}
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 0

                            Rectangle {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                color: "transparent"

                                RowLayout {
                                    anchors.left: parent.left
                                    height: parent.height
                                    width: children.width

                                    spacing: 10

                                    Icons {
                                        id: arch
                                        name: "distributor-logo-archman"
                                        iconColor: secondary

                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                if (systemWidgetVisible === false)
                                                {
                                                    systemWidgetVisible = true
                                                }
                                                else if(systemWidgetVisible === true)
                                                {
                                                    systemWidgetVisible = false
                                                }
                                            }
                                        }
                                    }
                                    Time { }
                                    Media { }
                                }



                            }

                            Workspaces { }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                color: "transparent"

                                RowLayout {
                                    anchors.right: parent.right
                                    height: parent.height
                                    width: children.width

                                    spacing: 10




                                    Ram { }
                                    Cpu { }
                                    Bluetooth {}
                                    Sound { }
                                }
                            }

                        }

                    }