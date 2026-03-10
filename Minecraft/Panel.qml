import "../Global"
import "./Components"

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

PanelWindow {
    required property var modelData

    id: topBar
    implicitHeight: 65
    color: "transparent"

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }


    anchors {
        top: true
        left: true
        right: true
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 15

        Icons {
            id: arch
            name: "distributor-logo-archman"
            iconColor: secondary
            size: 20
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                width: workspaceList.width + 20
                height: parent.height
                color: primary
                border.color: light
                border.width: 0.5
                radius: 8

                ListView {
                    id: workspaceList
                    width: contentWidth
                    height: parent.height - 16
                    anchors.centerIn: parent
                    model: Hyprland.workspaces
                    orientation: ListView.Horizontal
                    spacing: 10

                    delegate: Rectangle {
                        width: 30
                        height: workspaceList.height
                        color: modelData.active ? secondary : primary
                        radius: 100

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                modelData.activate()
                            }
                        }
                        Text {
                            anchors.centerIn: parent
                            color: modelData.active ? primary : secondary
                            font.pixelSize: 15
                            text: modelData.id
                        }
                    }
                }
            }
        }

        Time {}
        Sound {}
    }
}
