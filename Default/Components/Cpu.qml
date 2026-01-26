import QtQuick
import QtQuick.Layouts
import Quickshell


Rectangle {
    Layout.preferredWidth: cpu.width + 20
    Layout.fillHeight: true

    color: secondary
    radius: 100


    Text {
        id: cpu

        anchors.leftMargin: 10
        anchors.centerIn: parent
        text: "CPU: " + cpuPercent + "%"
        font.pixelSize: 13
        color: primary
        font.bold: true
    }
}

