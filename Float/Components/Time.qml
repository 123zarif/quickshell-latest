import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    Layout.fillHeight: true
    Layout.preferredWidth: time.implicitWidth + 30
    color: primary
    border.color: light
    border.width: 0.5
    radius: 8

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Text {
        id: time

        width: contentWidth
        anchors.centerIn: parent
        color: secondary
        font.pixelSize: 16
        font.bold: true
        text: Qt.formatDateTime(clock.date, "ddd MM/dd hh:mm ap")
    }

}

