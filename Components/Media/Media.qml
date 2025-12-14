import "../"

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris




RowLayout {
    id: mediaContainer

    property string pic_url: ""



    Layout.preferredWidth: 300
    Layout.fillHeight: true


    MouseArea {
        id: hoverItem
        anchors.fill: parent
        hoverEnabled: true
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
            bottomLeftRadius: hoverItem.containsMouse ? 0: 100
            bottomRightRadius: hoverItem.containsMouse ? 0: 100
            visible: modelData.identity == "Spotify" ? true: false


            Spotify_Widget {
            player: modelData

        }


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

