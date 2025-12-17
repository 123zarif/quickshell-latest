import QtQuick
import QtQuick.Layouts
import Quickshell


Rectangle {
    id: clockContainer

    Layout.preferredWidth: hoverArea.containsMouse ? date.width + time.width + 30: time.width + 20
    Layout.fillHeight: true

    color: secondary
    radius: 100
    clip: true

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    MouseArea {
        id: hoverArea

        anchors.fill: clockContainer
        hoverEnabled: true
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
            font.family: font_family
            color: primary
            font.bold: true
        }

        Text {
            id: date

            Layout.alignment: Qt.AlignVCenter
            text: Qt.formatDateTime(clock.date, "MMMM dd, yyyy")
            font.pixelSize: 13
            font.family: font_family
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

