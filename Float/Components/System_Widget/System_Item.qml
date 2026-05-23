import "../../../Global"
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    property int index: 0
        property var title: ""
            property var icon_name: ""


                id: lockButton
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: selectedIndex == index ? Qt.rgba(212/255, 197/255, 160/255, 0.08) : Qt.rgba(0.0, 0.0, 0.0, 0.3)
                border.color: selectedIndex == index ? '#131313' : Qt.rgba(255, 255, 255, 0.02)
                border.width: 1

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        // Your click logic here
                    }
                }


                Behavior on color { ColorAnimation { duration: 200; easing.type: Easing.OutQuad } }
                Behavior on border.color { ColorAnimation { duration: 200; easing.type: Easing.OutQuad } }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 0
                    scale: selectedIndex == index ? 1.7 : 1

                    Behavior on scale {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutBack
                        easing.amplitude: 1.5
                    }
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: icon_name
                    color: selectedIndex == index ? "#FFFFFF" : "#EBEBEB"
                    font.pixelSize: 50
                    font.weight: 900
                    font.family: Colors.font
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: title
                    color: selectedIndex == index ? "#FFFFFF" : "#EBEBEB"
                    font.pixelSize: 35
                    font.weight: 900
                    font.family: Colors.font
                }
            }
        }