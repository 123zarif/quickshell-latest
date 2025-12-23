import "../"

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

PopupWindow {
    property var anchorTo: null

        id: soundSettingsPopup
        anchor.window: root

        anchor.rect.x: 0
        anchor.rect.y: root.height - 10

        implicitWidth: 300
        implicitHeight: list.height + 40
        visible: showWidget
        color: "transparent"

        Timer {
            interval: 50
            running: true
            repeat: false
            onTriggered: {
                let pos = anchorTo.mapToItem(root.contentItem, 0, 0)
                soundSettingsPopup.anchor.rect.x = pos.x - 300 + anchorTo.Layout.preferredWidth
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
                Layout.alignment: Qt.AlignRight

                Behavior on opacity {
                NumberAnimation {
                    duration: 400
                }
            }
        }
        Rectangle {
            opacity: showWidget ? 1 : 0
            color: secondary
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 10
            topRightRadius: 0

            Behavior on opacity {
            NumberAnimation {
                duration: 400
            }
        }

        ListView {
            id: list
            width: parent.width
            height: childrenRect.height
            model: Pipewire.nodes?.values.filter(node => node.isSink && !node.isStream)
            spacing: 10
            anchors.centerIn: parent
            anchors.margins: 10

            delegate: Rectangle {
                color: Pipewire?.defaultAudioSink?.id === modelData.id ? primary : "transparent"
                width: parent.width - 40
                height: row.height
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent
                    onClicked: {
                        if (Pipewire?.defaultAudioSink?.id === modelData.id) return
                        Pipewire.preferredDefaultAudioSink = modelData
                    }
                }

                RowLayout {
                    id: row
                    width: parent.width - 20
                    height: implicitHeight + 15
                    spacing: 10
                    Icons {
                        name: "object-select-symbolic"
                        color: secondary
                        size: 16
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 10
                        visible: Pipewire?.defaultAudioSink?.id === modelData.id
                    }
                    Text {
                        text: modelData.description.toUpperCase() || modelData.name.toUpperCase()
                        font.pixelSize: 16
                        font.weight: Font.Bold
                        color: Pipewire?.defaultAudioSink?.id === modelData.id ? secondary : primary
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                    }
                }
            }
        }
    }
}
}


