import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io


PopupWindow {


    id: systemPopup
    anchor.window: root
    anchor.rect.x: root.width
    anchor.rect.y: screen.height / 2 - systemPopup.height / 2
    implicitWidth: 100
    implicitHeight: 300
    color: "transparent"
    visible: systemWidgetVisible || backgroundRect.width > 0


    Process {
        id: lockProcess
        command: ["sh", "-c", "qs -p ~/.config/quickshell/Lock" ]
    }

    Process {
        id: shutdownProcess
        command: ["sh", "-c", "systemctl poweroff" ]
    }
    Process {
        id: restartProcess
        command: ["sh", "-c", "systemctl reboot" ]
    }

    Rectangle {
        id: backgroundRect
        anchors.right: parent.right
        height: parent.height
        width: systemWidgetVisible ? parent.width: 0
        color: secondary
        topLeftRadius: 200
        bottomLeftRadius: 200

        ColumnLayout {
            anchors.fill: parent
            anchors.centerIn: parent
            anchors.topMargin: 15
            anchors.bottomMargin: 15
            spacing: 10

            Rectangle {
                id: lockButton
                color: lockArea.containsMouse ? primary: "transparent"
                Layout.leftMargin: 15
                Layout.rightMargin: 15
                Layout.fillWidth: true
                height: 70
                radius: 20

                MouseArea {
                    id: lockArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        lockProcess.running = true
                    }
                }

                Icons {
                    anchors.centerIn: parent
                    name: "system-lock-screen-symbolic"
                    size: 40
                    iconColor: lockArea.containsMouse ? secondary: primary
                }

                Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }

        }
        Rectangle {
            id: shutdownButton
            color: shutdownArea.containsMouse ? '#9aff0000': "transparent"
            Layout.leftMargin: 15
            Layout.rightMargin: 15
            radius: 20

            MouseArea {
                id: shutdownArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    shutdownProcess.running = true
                }
            }


            Layout.fillWidth: true
            height: 70

            Icons {
                anchors.centerIn: parent
                name: "system-shutdown-panel"
                iconColor: shutdownArea.containsMouse ? "#fff": "red"
                size: 50
            }

            Behavior on color {
            ColorAnimation {
                duration: 300
            }
        }
    }

    Rectangle {
        id: restartButton
        color: restartArea.containsMouse ? primary: "transparent"
        Layout.leftMargin: 15
        Layout.rightMargin: 15
        Layout.fillWidth: true
        height: 70
        radius: 20

        MouseArea {
            id: restartArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                restartProcess.running = true
            }
        }

        Icons {
            anchors.centerIn: parent
            name: "system-restart-panel"
            iconColor: restartArea.containsMouse ? secondary: primary
            size: 50
        }

        Behavior on color {
        ColorAnimation {
            duration: 300
        }
    }
}
}

Behavior on width {
NumberAnimation {
    duration: 150
}
}
}

}