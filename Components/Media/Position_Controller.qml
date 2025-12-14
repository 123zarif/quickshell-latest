import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import QtQuick.Controls

Item{
    id: playback

    Layout.fillWidth: true
    height: 40




    FrameAnimation {
        running: player.playbackState == MprisPlaybackState.Playing
        onTriggered: player.positionChanged()
    }
    Timer {
        running: player.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: {
            player.positionChanged()
        }
    }

    ColumnLayout {
        width: parent.width
        height: parent.height

        spacing: 0

        RowLayout {
            width: parent.width
            Text {
                text: Math.floor(player.position/60).toString().padStart(2, '0') + ": " + Math.floor(player.position%60).toString().padStart(2, '0') + " / " + Math.round(player.length/60).toString().padStart(2, '0') + ": " + Math.round(player.length%60 ).toString().padStart(2, '0')
                font.pixelSize: 14
                font.family: root.font_family
                color: "#D3D2D2"
                font.bold: true
            }
            Text {
                text: "-" + Math.floor((player.length - player.position)/60).toString().padStart(2, '0') + ": " + Math.floor((player.length - player.position)%60).toString().padStart(2, '0')
                font.pixelSize: 14
                font.family: root.font_family
                color: "#D3D2D2"
                font.bold: true
                Layout.alignment: Qt.AlignRight
            }
        }

        Slider {
            id: slider
            Layout.fillWidth: true
            height: 10

            from: 0
            to: player.length
            value: player.position

            background: Rectangle {
                color: '#908484'
                width: slider.availableWidth
                height: parent.height
                radius: 20
                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: secondary
                    radius: 100
                }
            }

            handle: Rectangle {
                color: secondary
                width: 15
                height: 15
                anchors.verticalCenter: parent.verticalCenter
                radius: 100
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width) - 3
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
            }
        }
    }

}