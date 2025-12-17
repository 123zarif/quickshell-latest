import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland



FloatingWindow{
    id: laucnherPopup
    title: "launcher"
    minimumSize: "1000x600"
    maximumSize: "1000x600"
    visible: true
    color: "transparent"


    Rectangle{
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        color: '#9c000000'

        Rectangle{
            anchors.centerIn: parent
            color: "transparent"
            width: parent.width - 50
            height: parent.height - 30

            ColumnLayout {
                width: parent.width
                height: parent.height
                spacing: 10

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    height: 10
                    font.pixelSize: 24
                    leftInset: -10
                    color: "#fff"
                    placeholderText: "Search applications..."
                    placeholderTextColor: '#b2b2b2'
                    background: Rectangle {
                        color: "transparent"
                        border.color: "#fff"
                        border.width: 2
                        radius: 5
                    }
                }

                ScrollView {
                    id: scrollView
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    GridLayout{
                        id: grid
                        width: scrollView.availableWidth
                        height: parent.height
                        columns: 3
                        rowSpacing: 10
                        columnSpacing: 10

                        Repeater {
                            model: DesktopEntries.applications
                            Rectangle {
                                color: mouseArea.containsMouse ? '#1dffffff': "transparent"
                                height: 150
                                Layout.fillWidth: true

                                MouseArea {
                                    id: mouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor

                                    onClicked: {
                                        launcherWidgetVisible = false
                                        modelData.execute()
                                    }
                                }

                                ColumnLayout{
                                    id: column
                                    spacing: 1
                                    anchors.fill: parent
                                    anchors.centerIn: parent
                                    IconImage {
                                        Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
                                        implicitSize: 64
                                        source: Quickshell.iconPath(modelData.icon)
                                    }
                                    Text {
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        text: modelData.name
                                        color: "#fff"
                                        font.pixelSize: 20
                                    }
                                }
                            }
                        }
                    }
                }

            }
        }
    }
}