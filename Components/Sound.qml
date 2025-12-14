import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick.Controls

Rectangle {
    id: soundContainer

    Layout.preferredWidth: hoverArea.containsMouse || slider.hovered || slider.pressed ? soundValue.width + slider.width + 30: soundValue.width + 20
    Layout.fillHeight: true

    color: secondary
    radius: 100
    clip: true


    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    MouseArea {
        id: hoverArea

        anchors.fill: parent
        hoverEnabled: true

    }

    RowLayout {
        anchors.fill: parent

        anchors.leftMargin: 10
        anchors.rightMargin: 10

        RowLayout {
            id: soundValue

            Layout.fillHeight: true
            spacing: 0

            Icons {
                name: Pipewire?.defaultAudioSink?.audio?.volume == 1 ? "audio-volume-high": Pipewire?.defaultAudioSink?.audio?.volume == 0 ? "audio-volume-muted": "audio-volume-medium"
            }

            Text {
                id: soundText

                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                text: Math.round(Pipewire?.defaultAudioSink?.audio?.volume * 100) + "%"
                font.pixelSize: 13
                font.family: font_family
                color: primary
                font.bold: true
            }
        }

        Slider {
            id: slider
            Layout.rightMargin: 10
            Layout.leftMargin: 5
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter



            Layout.preferredWidth: 100

            hoverEnabled: true

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                propagateComposedEvents: true
                onPressed: (mouse) => mouse.accepted = false
            }

            from: 0
            to: 1
            value: Pipewire?.defaultAudioSink?.audio?.volume ? Pipewire?.defaultAudioSink?.audio?.volume: 0

            background: Rectangle {
                color: light
                width: slider.availableWidth
                height: parent.height
                radius: 20
                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: primary
                    radius: 100
                }
            }

            handle: Rectangle {
                color: "transparent"
            }



            onValueChanged: {
                Pipewire.defaultAudioSink.audio.volume = value
            }

        }
    }

    Behavior on Layout.preferredWidth {
    NumberAnimation {
        duration: 300
        easing.type: Easing.OutCubic
    }

}

}

