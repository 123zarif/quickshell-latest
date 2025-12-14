import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris

PopupWindow {

    property var player: null


    anchor.window: root
    anchor.rect.x: 193
    anchor.rect.y: root.height - 10
    implicitWidth: 500
    implicitHeight: 400
    visible: hoverItem.containsMouse ? true: false

    color: secondary

    Image {
        anchors.fill: parent
        source: player?.trackArtUrl
        fillMode: Image.Tile
        smooth: true
    }

    Rectangle {
        anchors.fill: parent
        color: "#221E1E"
        opacity: 0.6
    }
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            Song_Details {}

            ColumnLayout {
                Layout.fillWidth: true
                height: playback.height + 30

                Layout.alignment: Qt.AlignBottom

                Position_Controller {}

                RowLayout {
                    Layout.fillWidth: true
                    height: 30


                }
            }

        }
    }
}