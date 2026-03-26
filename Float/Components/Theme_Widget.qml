import "../../Global"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    property var themes: []
    property int selectedIndex: 0

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    implicitWidth: screen.width
    implicitHeight: screen.height
    color: "transparent"

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Themes {
        id: themesSetting
    }

    Rectangle {
        id: main

        width: parent.width * 0.7
        height: 400
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 20
        color: active
        radius: 20
        border.color: secondary
        border.width: 2
        focus: true
        Keys.onRightPressed: {
            themesSetting.next();
        }
        Keys.onLeftPressed: {
            themesSetting.prev();
        }

        Item {
            id: layout

            anchors.fill: parent

            ListView {
                id: list

                model: themes
                anchors.fill: parent
                anchors.margins: 20
                orientation: ListView.Horizontal
                clip: true
                spacing: 20
                highlightMoveDuration: 300
                currentIndex: selectedIndex

                delegate: Rectangle {
                    width: 500
                    height: list.height
                    Layout.margins: 20
                    Layout.rightMargin: 0
                    color: selectedIndex === index ? secondary : primary
                    radius: 20

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        anchors.topMargin: 10
                        spacing: 10

                        Text {
                            text: modelData.name
                            font.pixelSize: 24
                            font.weight: Font.Bold
                            color: selectedIndex === index ? primary : secondary
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        }

                        Image {
                            source: "/home/zarif/.config/colorSchemes/wallpapers/" + modelData.wallpaper
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            fillMode: Image.PreserveAspectCrop
                        }

                    }

                }

            }

        }

    }

}
