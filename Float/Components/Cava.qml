import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: visualizer

    implicitWidth: rowContainer.width
    Layout.fillHeight: true
    Layout.bottomMargin: 10

    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

    property var audioData: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

    Process {
        id: cavaProcess
        command: ["cava", "-p", Quickshell.env("HOME") + "/.config/cava/quickshell_config"]
        running: true

        stdout: SplitParser {
            onRead: data => {
            const line = data.trim();
            if (line === "") return;

            const values = line.split(";")
            .filter(val => val !== "")
            .map(val => parseInt(val, 10));

            visualizer.audioData = values;
        }
    }
}

Row {
    id: rowContainer

    anchors.bottom: parent.bottom
    spacing: 4

    Repeater {
        model: visualizer.audioData.length

        Rectangle {
            width: 10

            height: Math.max(5, (visualizer.audioData[index] / 100) * visualizer.height - 6)

            color: secondary
            radius: 2

            anchors.bottom: parent.bottom

            Behavior on height {
            NumberAnimation {
                duration: 50
                easing.type: Easing.OutSine
            }
        }
    }
}
}
}