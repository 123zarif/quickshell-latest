import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
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
            id: applyWallpaper
            command: ["sh", "-c", `awww img --transition-fps 144 --transition-step 155 --transition-type wave ${basePath}/colorSchemes/wallpapers/${themes.themes[selectedIndex].wallpaper}`]
        }


        property var themes: null
            property int selectedIndex: 0

                Component.onCompleted: {
                    themes = JSON.parse(colorsJson.text())

                    var foundIndex = themes.themes.findIndex((theme) => theme.selected)
                    selectedIndex = (foundIndex !== -1) ? foundIndex : 0

                    layout.visible = true
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
                    applyWallpaper.running = true
                    colorsJson.setText(JSON.stringify(themes))

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
                            themes.themes[selectedIndex].selected = false
                            themes.themes[selectedIndex + 1].selected = true
                            selectedIndex += 1
                            updateTheme(selectedIndex)
                        }
                        else {
                            themes.themes[selectedIndex].selected = false
                            themes.themes[0].selected = true
                            selectedIndex = 0
                            updateTheme(selectedIndex)
                        }

                    }

                    Keys.onLeftPressed: {
                        if (selectedIndex > 0)
                        {
                            themes.themes[selectedIndex].selected = false
                            themes.themes[selectedIndex - 1].selected = true
                            selectedIndex -= 1
                            updateTheme(selectedIndex)
                        }
                        else {
                            themes.themes[selectedIndex].selected = false
                            themes.themes[themes.themes.length - 1].selected = true
                            selectedIndex = themes.themes.length - 1
                            updateTheme(selectedIndex)
                        }
                    }



                    Item {
                        id: layout
                        visible: false
                        anchors.fill: parent

                        ListView {
                            id: list
                            model: themes.themes
                            anchors.fill: parent
                            anchors.margins: 20
                            orientation: ListView.Horizontal
                            clip: true
                            spacing: 20
                            highlightMoveDuration: 300
                            currentIndex: selectedIndex


                            delegate: Rectangle {
                                width: 500
                                height: list.height
                                Layout.margins: 20
                                Layout.rightMargin: 0
                                color: selectedIndex === index ? secondary: light
                                radius: 20

                                ColumnLayout {
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
