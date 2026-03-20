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


    Timer {
        id: grace
        interval: 1000
        running: false
        repeat: false
        onTriggered: {
            update.running = true
        }
    }


    function prev()
    {
        if (!themes || themes.length === 0) return;
        grace.running = false

        if (selectedIndex > 0)
        {
            themes[selectedIndex].selected = false
            themes[selectedIndex - 1].selected = true
            selectedIndex -= 1
        }
        else {
            themes[selectedIndex].selected = false
            themes[themes.length - 1].selected = true
            selectedIndex = themes.length - 1
        }
        grace.running = true
    }

    function next()
    {
        if (!themes || themes.length === 0) return;
        grace.running = false

        if (selectedIndex < themes.length - 1)
        {
            themes[selectedIndex].selected = false
            themes[selectedIndex + 1].selected = true
            selectedIndex += 1
        }
        else {
            themes[selectedIndex].selected = false
            themes[0].selected = true
            selectedIndex = 0
        }
        grace.running = true

    }
}