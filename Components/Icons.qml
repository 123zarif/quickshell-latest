import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import QtQuick.Controls


Rectangle {
    property string name: "audio-volume-muted"
    property color iconColor: primary
    property bool overlay: true
    property int size: 15

    width: size
    color: "transparent"

    IconImage {
        id: soundImg

        anchors.centerIn: parent

        implicitSize: size
        source: Quickshell.iconPath(name)
    }

    ColorOverlay {
        anchors.centerIn: parent
        width: soundImg.width
        height: soundImg.height
        source: soundImg
        color: iconColor

        visible: overlay
    }
}
