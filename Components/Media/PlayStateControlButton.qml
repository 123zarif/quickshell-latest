import "../"

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris


Rectangle {
    property string icon_name: "media-skip-backward"
    property int type: 1


    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            if (type === 1)
            {
                prevHovering = true
            }
            else if (type === 2)
            {
                playHovering = true
            }
            else (type === 3)
            {
                nextHovering = true
            }

            graceTimer.start()
        }
        onExited: {
            if (type === 1)
            {
                prevHovering = false
            }
            else if (type === 2)
            {
                playHovering = false
            }
            else (type === 3)
            {
                nextHovering = false
            }

            graceTimer.start()
        }

        onClicked: {
            if (type === 2)
            {
                player.togglePlaying()

            }
            else if (type === 1)
            {
                player.previous()

            }
            else if (type === 3)
            {
                player.next()
            }
        }
    }


    width: 50
    height: 50
    radius: 50
    color: '#31000000'



    Icons {
        name: icon_name
        iconColor: secondary
        size: 25
        anchors.centerIn: parent
    }

}