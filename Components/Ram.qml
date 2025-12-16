import QtQuick
import QtQuick.Layouts
import Quickshell


Rectangle {
    id: ramContainer


    Layout.preferredWidth: hoverArea.containsMouse ? ramPercentage.width + ramDetails.width + 30: ramDetails.width - 10
    Layout.fillHeight: true

    color: secondary
    radius: 100
    clip: true




    MouseArea {
        id: hoverArea

        anchors.fill: ramContainer
        hoverEnabled: true
    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        Text {
            id: ramPercentage

            Layout.leftMargin: 10
            Layout.alignment: Qt.AlignVCenter
            text: "RAM: " + memPercent.toString().padStart(2, '0') + "%"
            font.pixelSize: 13
            font.family: font_family
            color: primary
            font.bold: true
        }

        Text {
            id: ramDetails
            Layout.rightMargin: 10
            text: memUsed.toString() + "GiB / " + memTotal + "GiB"
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

