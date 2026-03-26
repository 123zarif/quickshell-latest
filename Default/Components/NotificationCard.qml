import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications

PanelWindow {
    id: notificationPanel
    anchors {
        top: true
        left: true
    }

    implicitWidth: 380
    implicitHeight: Math.min(notifList.contentHeight, 800)

    color: "transparent"



    NotificationServer {
        id: server
        bodySupported: true
        imageSupported: true

        onNotification: (n) => {
        n.tracked = true
    }
}
ListView {
    id: notifList
    anchors.fill: parent
    model: server.trackedNotifications
    spacing: 12
    clip: true

    delegate: Rectangle {
        width: notifList.width
        height: contentLayout.implicitHeight + 20
        color: "#1e1e2e"
        radius: 12
        border.color: "#45475a"
        border.width: 1

        Timer {
            interval: 10000
            running: true
            repeat: false
            onTriggered: modelData.dismiss()
        }

        RowLayout {
            id: contentLayout
            anchors {
                fill: parent
                margins: 10
            }
            spacing: 12

            Image {
                source: (modelData.image ? modelData.image: (modelData.icon ? modelData.icon : ""))
                visible: source !== ""

                Layout.alignment: Qt.AlignTop
                Layout.preferredWidth: 64
                Layout.preferredHeight: 64
                fillMode: Image.PreserveAspectCrop
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                spacing: 4
                Text {
                    Layout.fillWidth: true
                    text: modelData.appName + " - " + modelData.summary
                    color: "#cdd6f4"
                    font.bold: true
                    font.pixelSize: 14
                    wrapMode: Text.Wrap
                }
                Text {
                    Layout.fillWidth: true
                    text: modelData.body
                    color: "#a6adc8"
                    font.pixelSize: 13
                    wrapMode: Text.Wrap
                    textFormat: Text.PlainText
                    visible: modelData.body !== ""
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                modelData.dismiss()
            }
        }
    }
}
}
