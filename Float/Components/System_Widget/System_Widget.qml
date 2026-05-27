import "../../../Global"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io


PanelWindow {

    property int selectedIndex: 0

        id: systemPopup
        exclusionMode: ExclusionMode.Ignore
        focusable: true
        color: "transparent"
        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }



        Process {
            id: lockProcess
            command: ["sh", "-c", "qs -p ~/.config/quickshell/Lock" ]
        }

        Process {
            id: sleepProcess
            command: ["sh", "-c", "systemctl suspend"]
        }

        Process {
            id: shutdownProcess
            command: ["hyprctl", "dispatch", "exec", "hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'"]
        }
        Process {
            id: restartProcess
            command: ["hyprctl", "dispatch", "exec", "hyprshutdown -t 'Restarting...' --post-cmd 'systemctl reboot'"]
        }

        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0.12, 0.12, 0.15, 0.8)

            focus: true

            Keys.onLeftPressed: (event) => {
            selectedIndex = (selectedIndex <= 0) ? 3 : selectedIndex - 1
            event.accepted = true
        }

        Keys.onRightPressed: (event) => {
        selectedIndex = (selectedIndex >= 3) ? 0 : selectedIndex + 1
        event.accepted = true
    }
    Keys.onReturnPressed: (event) => {
    if (selectedIndex == 0) sleepProcess.running = true
    if (selectedIndex == 1) lockProcess.running = true
    if (selectedIndex == 2) shutdownProcess.running = true
    if (selectedIndex == 3) restartProcess.running = true
    event.accepted = true
}

RowLayout {
    anchors.fill: parent

    System_Item {index: 0; title: "Sleep"; icon_name: "\udb82\udd04" }
    System_Item {index: 1; title: "Lock"; icon_name: "\udb80\udf3e" }
    System_Item {index: 2; title: "Shut Down"; icon_name: "\u23fb" }
    System_Item {index: 3; title: "Restart"; icon_name: "\udb81\udf09" }

}
}


}
