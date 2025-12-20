import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

FloatingWindow {
    property string basePath: "/home/zarif/.config"

    title: "theme"
    minimumSize: Qt.size(screen.width, screen.height)
    maximumSize: Qt.size(screen.width, screen.height)
    color: "transparent"

    FileView {
        id: colorsJson
        path: Qt.resolvedUrl("/home/zarif/.config/colorSchemes/themes.json")
        blockLoading: true
    }
    FileView {
        id: quickshellColorsJson
        path: Qt.resolvedUrl("../persists/colors.json")
    }
    FileView {
        id: hyprlandColorsJson
        path: Qt.resolvedUrl("/home/zarif/.config/hypr/colors.conf")
    }

    Process {
        id: unloadWallpaper
        command: ["sh", "-c", `hyprctl hyprpaper unload all`]
    }

    Process {
        id: applyWallpaper
        command: ["sh", "-c", `hyprctl hyprpaper wallpaper ', ${basePath}/colorSchemes/wallpapers/${themes.themes[selectedIndex].wallpaper}'`]
        stdout: StdioCollector {
            onStreamFinished: if(this.text.trim() == "ok") unloadWallpaper.running = true
        }
    }

    Process {
        id: preloadWallpaper
        command: ["sh", "-c", `hyprctl hyprpaper preload '${basePath}/colorSchemes/wallpapers/${themes.themes[selectedIndex].wallpaper}'`]
        stdout: StdioCollector {
            onStreamFinished: if(this.text.trim() == "ok") applyWallpaper.running = true
        }
    }


    readonly property var themes: JSON.parse(colorsJson.text())
    property int selectedIndex: 0


    Timer {
        interval: 200
        running: true
        repeat: false
        onTriggered: {
            selectedIndex = themes.themes.findIndex((theme) => theme.selected)
            layout.visible = true
        }
    }

    function updateTheme(index)
    {
        const keys = Object.keys(themes.themes[index].colors)
        let data = ""

        for (let key of keys) {
        const color = themes.themes[index].colors[key].replace("#", "")
        data += `$${key} = rgb(${color}) \n`
    }

    hyprlandColorsJson.setText(data)
    quickshellColorsJson.setText(JSON.stringify(themes.themes[index].colors))

    primary = themes.themes[index].colors.primary
    secondary = themes.themes[index].colors.secondary
    light = themes.themes[index].colors.light
    active = themes.themes[index].colors.active
    preloadWallpaper.running = true
}


Rectangle {
    id: main
    width: parent.width * 0.7
    height: 400
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.margins: 20
    color: primary
    radius: 20
    border.color: secondary
    border.width: 2

    focus: true

    Keys.onRightPressed: {
        if (selectedIndex < themes.themes.length - 1)
        {
            selectedIndex += 1
            updateTheme(selectedIndex)
        }
        else {
            selectedIndex = 0
            updateTheme(selectedIndex)
        }

    }

    Keys.onLeftPressed: {
        if (selectedIndex > 0)
        {
            selectedIndex -= 1
            updateTheme(selectedIndex)
        }
        else {
            selectedIndex = themes.themes.length - 1
            updateTheme(selectedIndex)
        }
    }

    RowLayout{
        id: layout
        visible: false
        height: parent.height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        Repeater {
            model: themes.themes

            Rectangle {
                Layout.preferredWidth: 500
                Layout.fillWidth: false
                Layout.fillHeight: true
                Layout.margins: 20
                Layout.rightMargin: 0
                color: selectedIndex === index ? secondary: light
                radius: 20

                ColumnLayout{
                    anchors.fill: parent
                    anchors.margins: 20
                    anchors.topMargin: 10
                    spacing: 10
                    Text {
                        text: modelData.name
                        font.pixelSize: 24
                        font.weight: Font.Bold
                        color: selectedIndex === index ? primary: secondary
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    }
                    Image {
                        source: "/home/zarif/.config/colorSchemes/wallpapers/" + modelData.wallpaper
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        fillMode: Image.PreserveAspectCrop
                    }
                }
            }
        }
    }
}
}


