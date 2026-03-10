import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

    Rectangle {
        anchors.right: parent.right
        width: soundLayout.width + 20
        height: parent.height
        color: primary
        border.color: light
        border.width: 0.5
        radius: 8

        RowLayout {
            id: soundLayout
            anchors.centerIn: parent
            spacing: 10

            Text {
                color: secondary
                font.pixelSize: 14
                text: Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%"

            }
        }
    }
}