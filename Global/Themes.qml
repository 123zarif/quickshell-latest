import Quickshell.Io
import QtQuick

Item {
    Process {
        id: get
        running: true
        command: [ "sh", "-c", "theme list -j" ]
        stdout: StdioCollector {
            onStreamFinished: {
                const fetched = JSON.parse(JSON.parse(this.text))
                themes = fetched.themes

                var foundIndex = themes.findIndex((theme) => theme.selected)
                selectedIndex = (foundIndex !== -1) ? foundIndex : 0
            }
        }
    }


    Process {
        id: update
        running: false
        command: [ "hyprctl", "dispatch", "exec", `theme select -i ${selectedIndex}` ]
    }

    function change()
    {
        update.running = true
    }
}