import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import Qt5Compat.GraphicalEffects


PopupWindow {
    id: spotifyPopup
    anchor.window: root
    property Item popupAnchor: null

    anchor.rect.x: popupAnchor.x + 15
    anchor.rect.y: root.height - 10

    implicitWidth: 500
    implicitHeight: 400
    visible: showWidget || widgetBackground.opacity > 0

    property var player: null
    color: "transparent"
    Rectangle {
        id: widgetBackground

        opacity: showWidget ? 1: 0
        Behavior on opacity {
        NumberAnimation {
            duration: 350
        }
    }

    anchors.fill: parent

    topRightRadius: 50
    topLeftRadius: 0
    bottomRightRadius: 50
    bottomLeftRadius: 50

    clip: true
    color: "transparent"

    MouseArea {
        id: hoverItemWidget
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            widgetHovering = true

            graceTimer.start()
        }
        onExited: {
            widgetHovering = false

            graceTimer.start()
        }

    }


    Item {
        anchors.fill: parent


        Image {
            id: albumArt
            anchors.fill: parent
            source: player?.trackArtUrl ?? ""
            fillMode: Image.PreserveAspectCrop
            smooth: true
            visible: false
        }

        Rectangle {
            id: maskRect
            anchors.fill: parent
            topRightRadius: widgetBackground.topRightRadius
            topLeftRadius: widgetBackground.topLeftRadius
            bottomRightRadius: widgetBackground.bottomRightRadius
            bottomLeftRadius: widgetBackground.bottomLeftRadius

            visible: false
        }

        OpacityMask {
            anchors.fill: parent
            source: albumArt
            maskSource: maskRect
        }
    }
    // Image {
    //     anchors.fill: parent
    //     source: player?.trackArtUrl
    //     fillMode: Image.Tile
    //     smooth: true
    // }


    Rectangle {
        anchors.fill: parent
        color: "#221E1E"
        opacity: 0.6
        topRightRadius: widgetBackground.topRightRadius
        topLeftRadius: widgetBackground.topLeftRadius
        bottomRightRadius: widgetBackground.bottomRightRadius
        bottomLeftRadius: widgetBackground.bottomLeftRadius
    }

    Item {
        anchors.fill: parent
        anchors.margins: 20
        Song_Details {}

        ColumnLayout{
            anchors.bottom: parent.bottom
            width: parent.width
            height: childrenRect.height

            spacing: 20

            Position_Controller {}

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                spacing: 20

                PlayStateControlButton {
                    type: 1
                    icon_name: "media-skip-backward"
                }
                PlayStateControlButton {
                    type: 2
                    icon_name: player.isPlaying ? "media-pause": "media-play"

                }
                PlayStateControlButton {
                    type: 3
                    icon_name: "media-skip-forward"
                }
            }
        }


    }

}

}