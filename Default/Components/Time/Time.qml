import QtQuick
import QtQuick.Layouts
import Quickshell


Rectangle {
    property bool hovering: false
        property bool showWidget: false

            id: clockContainer

            Layout.preferredWidth: hovering ? date.width + time.width + 30: time.width + 20
            Layout.fillHeight: true

            color: secondary
            radius: 100
            bottomLeftRadius: hovering ? 0 : 100
            bottomRightRadius: hovering ? 0 : 100
            clip: true

            Timer {
                id: graceTimer
                interval: 200
                running: false
                repeat: false
                onTriggered: {
                    showWidget = hovering
                }
            }

            SystemClock {
                id: clock

                precision: SystemClock.Minutes
            }

            MouseArea {
                id: hoverArea

                anchors.fill: clockContainer
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

            Calendar_Widget {
            anchorTo: clockContainer
        }

        RowLayout {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Text {
                id: time

                Layout.leftMargin: 10
                Layout.alignment: Qt.AlignVCenter
                text: Qt.formatDateTime(clock.date, "hh:mm AP | dddd")
                font.pixelSize: 13
                color: primary
                font.bold: true
            }

            Text {
                id: date

                Layout.alignment: Qt.AlignVCenter
                text: Qt.formatDateTime(clock.date, "MMMM dd, yyyy")
                font.pixelSize: 13
                color: primary
                font.bold: true
            }

        }

        Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }

    }

}

