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

    implicitHeight: 65
    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
    }

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Rectangle {
        id: conatiner

        anchors.centerIn: parent
        width: row.implicitWidth + 50
        radius: 200
        height: parent.height - 25
        color: Colors.primary
        border.width: 2
        border.color: secondary

        RowLayout {
            id: row

            anchors.centerIn: parent
            height: parent.height
            spacing: 25

            ListView {
                id: workspaces

                interactive: false
                orientation: ListView.Horizontal
                spacing: 20
                Layout.preferredWidth: contentWidth
                Layout.fillHeight: true
                model: {
                    let wsArray = Hyprland.workspaces.values.slice();
                    return wsArray.sort((a, b) => {
                        if (a.id > 0 && b.id < 0)
                            return -1;

                        if (a.id < 0 && b.id > 0)
                            return 1;

                        return a.id - b.id;
                    });
                }

                delegate: Workspace {
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

        Behavior on width {
            NumberAnimation {
                duration: 100
                easing.type: Easing.InOutQuad
            }

        }

    }

}
