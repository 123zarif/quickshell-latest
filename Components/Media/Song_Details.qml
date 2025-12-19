import QtQuick
import QtQuick.Layouts
import Quickshell


Rectangle{
    anchors.top: parent.top
    width: column.width + 40
    height: trackTitle.height + trackArtist.height + 30
    radius: 20
    color: '#a8000000'
    opacity: 1
    ColumnLayout {
        id: column
        anchors.centerIn: parent
        spacing: 5

        Text {
            id: trackTitle
            text: player?.trackTitle
            color: secondary
            font.bold: true
            font.pointSize: 14

        }

        Text {
            id: trackArtist
            text: "@" +player?.trackArtist
            color: secondary
            opacity: 0.7
            font.pointSize: 12
        }
    }
}
