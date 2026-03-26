import "../../Global/"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Pipewire

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true

    Rectangle {
        anchors.right: parent.right
        width: soundLayout.width + 20
        height: parent.height
        color: Colors.primary
        border.color: Colors.light
        border.width: 0.5
        radius: 8

        RowLayout {
            id: soundLayout

            anchors.centerIn: parent
            spacing: 5

            Icons {
                iconColor: Colors.secondary
                name: Pipewire.defaultAudioSink ? (Pipewire.defaultAudioSink.audio.volume >= 0.5 ? "audio-volume-high" : (Pipewire.defaultAudioSink.audio.volume === 0 ? "audio-volume-muted" : "audio-volume-medium")) : "audio-volume-muted"
            }

            Text {
                color: Colors.secondary
                font.pixelSize: 14
                text: (Pipewire.defaultAudioSink ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) : 0) + "%"
            }

            Slider {
                id: slider

                Layout.rightMargin: 10
                Layout.leftMargin: 5
                Layout.topMargin: 10
                Layout.bottomMargin: 10
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                Layout.preferredWidth: 200
                Layout.preferredHeight: 15
                hoverEnabled: true
                from: 0
                to: 1
                value: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.volume : 0
                onMoved: {
                    if (Pipewire.defaultAudioSink) {
                        if (value > 0) {
                            if (Pipewire.defaultAudioSink.audio.muted)
                                Pipewire.defaultAudioSink.audio.muted = false;

                            Pipewire.defaultAudioSink.audio.volume = value;
                        } else {
                            Pipewire.defaultAudioSink.audio.muted = true;
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    propagateComposedEvents: true
                    onPressed: (mouse) => {
                        return mouse.accepted = false;
                    }
                }

                background: Rectangle {
                    color: Colors.primary
                    width: slider.availableWidth
                    height: parent.height
                    radius: 20

                    Rectangle {
                        width: slider.visualPosition * parent.width
                        height: parent.height
                        color: Colors.secondary
                        radius: 100
                    }

                }

                handle: Rectangle {
                    color: "transparent"
                }

            }

        }

    }

}
