import "../"

import QtQuick
import QtQuick.Layouts
import Quickshell

PopupWindow {
    property var anchorTo: null

        id: calendarPopup
        anchor.window: root

        anchor.rect.x: 0
        anchor.rect.y: root.height - 10

        implicitWidth: 500
        implicitHeight: calendarContent.implicitHeight + 20
        visible: showWidget
        color: "transparent"

        Timer {
            interval: 50
            running: showWidget
            repeat: false
            onTriggered: {
                let pos = anchorTo.mapToItem(root.contentItem, 0, 0)
                calendarPopup.anchor.rect.x = pos.x
            }
        }


        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                hovering = true
                graceTimer.running = true
            }
            onExited: {
                hovering = false
                graceTimer.running = true
            }
        }


        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            Rectangle {
                opacity: showWidget ? 1 : 0
                color: secondary
                Layout.preferredWidth: anchorTo.Layout.preferredWidth
                Layout.preferredHeight: 10
                Layout.alignment: Qt.AlignLeft

                Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }
        }
        Rectangle {
            opacity: showWidget ? 1 : 0
            color: secondary
            Layout.fillWidth: true
            // Layout.preferredHeight: calendarContent.height
            Layout.fillHeight: true
            // Layout.fillHeight: true
            radius: 10
            topLeftRadius: 0

            Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }

        Calendar {
            id: calendarContent
        }
    }
}
}


