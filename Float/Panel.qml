import "../Global"
import "./Components"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

PanelWindow {
    id: topBar

    required property var modelData

    color: "transparent"
    implicitHeight: 65

    anchors {
        top: true
        left: true
        right: true
    }

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Item {
        width: parent.width
        anchors.centerIn: parent
        height: parent.height - 25

        RowLayout {
            width: screen.width
            spacing: 15
            anchors.centerIn: parent
            height: parent.height

            Item {
                Layout.fillWidth: true
            }

            Rectangle {
                color: Colors.primary
                Layout.fillHeight: true
                width: 40
                border.width: 2
                border.color: secondary
                radius: 200

                Text {
                    anchors.centerIn: parent
                    text: "\udb82\udcc7"
                    font.pixelSize: 20
                    color: Colors.secondary
                    font.family: Colors.font
                }

            }

            Rectangle {
                Layout.preferredWidth: special_row.width + 20
                radius: 200
                Layout.fillHeight: true
                color: Colors.primary
                border.width: 2
                border.color: secondary

                RowLayout {
                    id: special_row
                    width: implicitWidth
                    height: parent.height
                    anchors.centerIn: parent

                    Repeater {
                        model: Hyprland.workspaces.values.filter(itm => itm.id < 0)


                        delegate: Workspace {

                        }
                    }
                }
            }



            Rectangle {
                Layout.preferredWidth: row.width + 50
                radius: 200
                Layout.fillHeight: true
                color: Colors.primary
                border.width: 2
                border.color: secondary

                RowLayout {
                    id: row

                    anchors.centerIn: parent
                    height: parent.height
                    spacing: 25

                    RowLayout {
                        spacing: 10
                        Layout.fillHeight: true

                        Repeater {
                            model: Hyprland.workspaces.values.filter(itm => itm.id >= 0)


                            delegate: Workspace {
                            }
                        }
                    }

                    Text {
                        id: time

                        Layout.alignment: Qt.AlignCenter
                        text: Qt.formatDateTime(clock.date, "hh:mm AP | MMM dd")
                        font.pixelSize: 16
                        color: Colors.secondary
                        font.bold: true
                        font.family: Colors.font
                    }

                    Repeater {
                        model: Mpris.players.values.filter((itm) => {
                        return itm.identity == "Spotify";
                    })

                    Text {
                        id: media

                        font.strikeout: true
                        Layout.alignment: Qt.AlignCenter
                        text: "\uf1bc" + " " + modelData.trackTitle
                        font.pixelSize: 16
                        color: Colors.secondary
                        font.bold: true
                        font.family: Colors.font
                    }

                }

            }

            Behavior on Layout.preferredWidth {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutExpo // Fast start, very smooth slow down
                easing.overshoot: 1.2
            }
        }

    }

    Item {
        Layout.fillWidth: true
    }

}

}

}
