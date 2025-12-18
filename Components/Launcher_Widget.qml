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
    visible: true
    color: '#24000000'
    minimumSize: Qt.size(screen.width, screen.height)
    maximumSize: Qt.size(screen.width, screen.height)

    property string crrText: ""

    Timer {
        interval: 100
        running: true
        repeat: false
        onTriggered: {
            main.visible = true
            searchField.forceActiveFocus()
        }
    }


    Rectangle{
        id: main
        anchors.centerIn: parent
        width: 1000
        height: 600
        color: '#a6000000'
        radius: 40
        visible: false

        Rectangle{
            anchors.centerIn: parent
            color: "transparent"
            width: parent.width - 70
            height: parent.height - 50

            ColumnLayout {
                width: parent.width
                height: parent.height
                spacing: 30

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    height: 15
                    font.pixelSize: 20
                    leftInset: -10
                    bottomInset: -5
                    topInset: -5
                    color: "#fff"

                    placeholderText: "Search applications..."
                    placeholderTextColor: '#b2b2b2'
                    background: Rectangle {
                        color: "transparent"
                        border.color: "#fff"
                        border.width: 2
                        radius: 5
                    }

                    onTextChanged: {
                        crrText = text
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
                        rowSpacing: 25
                        columnSpacing: 10

                        Repeater {
                            model: DesktopEntries.applications

                            Item {
                                width: grid.width / grid.columns - grid.columnSpacing * (grid.columns - 1)
                                height: 140
                                visible: modelData.name.toLowerCase().includes(crrText.toLowerCase())

                                Rectangle {
                                    color: mouseArea.containsMouse ? '#fff': "transparent"
                                    opacity: mouseArea.containsMouse ? 0.15: 0
                                    width: parent.width
                                    height: parent.height

                                    Behavior on opacity {
                                    NumberAnimation {
                                        duration: 300
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                            }
                            Rectangle {
                                color: "transparent"
                                width: parent.width
                                height: parent.height

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
                                    spacing: 0
                                    anchors.fill: parent
                                    anchors.centerIn: parent

                                    IconImage {
                                        Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
                                        implicitSize: mouseArea.containsMouse ? 85: 60
                                        source: Quickshell.iconPath(modelData.icon)

                                        Behavior on implicitSize {
                                        NumberAnimation {
                                            duration: 150
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                }
                                Text {
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillWidth: true
                                    Layout.margins: 5
                                    horizontalAlignment: Text.AlignHCenter
                                    text: modelData.name
                                    elide: Text.ElideRight
                                    color: "#fff"
                                    font.weight: 700
                                    font.pixelSize: mouseArea.containsMouse ? 22: 20

                                    Behavior on font.pixelSize {
                                    NumberAnimation {
                                        duration: 150
                                        easing.type: Easing.InOutQuad
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
}
}
}