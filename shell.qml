import "./Components"
import "./Components/Media"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland



PanelWindow {
    id: root

    property string font_family: "Helvetica"
    property color primary: "#221E1E"
    property color secondary: "#D3D2D2"
    property color light: "#5E5E67"
    property color active: '#55df46'


    property double memUsed: 0
    property double memTotal: 1
    property int memPercent: 0

    property int lastCpuIdle: 0
    property int lastCpuTotal: 1
    property int cpuPercent: 0





    Process {
        id: memProcess
        command: ["sh", "-c", "free | grep Mem" ]
        stdout: SplitParser {
            onRead: data => {
            var parts = data.trim().split(/\s+/);
            var total = parseInt(parts[1]) || 1;
            var used = parseInt(parts[2]) || 1;

            var totalGib = (total / 1024 / 1024).toFixed(1);
            var usedGib = (used / 1024 / 1024).toFixed(1);
            var percentUsed = Math.round(((used / total) * 100));

            memTotal = totalGib;
            memUsed = usedGib;
            memPercent = percentUsed;
        }
    }

}

Process {
    id: cpuProcess
    command: ["sh", "-c", "grep '^cpu ' /proc/stat" ]
    stdout: SplitParser {
        onRead: data => {
        var parts = data.trim().split(/\s+/);
        var idle = parseInt(parts[4]) + parseInt(parts[5]);
        const total = parts.slice(1).reduce((acc, val) => acc + parseInt(val), 0);

        if (lastCpuTotal > 0)
        {
            cpuPercent = (100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal))).toFixed(2);

        }

        lastCpuIdle = idle;
        lastCpuTotal = total;
    }
}

}

Timer {
    interval: 3000
    running: true
    repeat: true
    onTriggered: {
        memProcess.running = true
        cpuProcess.running = true
    }
}



implicitHeight: 50

color: "transparent"

anchors {
    top: true
    left: true
    right: true
}

RowLayout {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 0

    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true
        color: "transparent"

        RowLayout {
            anchors.left: parent.left
            height: parent.height
            width: children.width

            spacing: 10

            Icons {
                id: arch
                name: "distributor-logo-archman"
                iconColor: secondary
            }
            Time { }
            Media { }
        }



    }

    Workspaces { }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true

        color: "transparent"

        RowLayout {
            anchors.right: parent.right
            height: parent.height
            width: children.width

            spacing: 10




            Ram { }
            Cpu { }
            Sound { }
        }
    }

}

}
