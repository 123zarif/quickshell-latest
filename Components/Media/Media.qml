import "../"

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris



Item {
    id: mediaContainer
    Layout.preferredWidth: 120
    Layout.fillHeight: true

    property string pic_url: ""

    property bool showWidget: false

    property bool mainHovering: false
    property bool widgetHovering: false
    property bool sliderHovering: false
    property bool prevHovering: false
    property bool playHovering: false
    property bool nextHovering: false


    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            mainHovering = true

            graceTimer.start()
        }
        onExited: {
            mainHovering = false

            graceTimer.start()
        }
    }

    RowLayout {
        anchors.fill: parent


        Timer {
            id: graceTimer
            interval: 50
            running: false
            repeat: false
            onTriggered: {
                if (mainHovering || widgetHovering || sliderHovering || prevHovering || playHovering || nextHovering)
                {
                    showWidget = true
                }
                else {
                    showWidget = false
                }
            }
        }

        Repeater {
            model: Mpris.players

            Rectangle {
                id: rect
                Layout.fillHeight: true
                Layout.preferredWidth: childrenRect.width + 21
                color: secondary
                topLeftRadius: 100
                topRightRadius: 100
                bottomLeftRadius: showWidget ? 0: 100
                bottomRightRadius: showWidget ? 0: 100
                visible: modelData.identity == "Spotify" ? true: false


                Spotify_Widget { player: modelData }


                RowLayout {
                    anchors.leftMargin: 10
                    anchors.centerIn: parent
                    spacing: 3

                    Icons {
                        name: "spotify"
                        overlay: false
                        size: 20
                    }

                    Text {

                        id: trackTitle
                        text: modelData.trackTitle
                        font.pixelSize: 13
                        font.family: font_family
                        color: primary
                        font.bold: true
                    }
                }
            }
        }
    }
}