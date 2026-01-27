import "./Default" as Default
import "./Minecraft" as Minecraft
import QtQuick
import Quickshell
import Quickshell.Io


ShellRoot {
    FileView {
        id: colorsJson
        path: Qt.resolvedUrl("./persists/colors.json")
        blockLoading: true
    }

    readonly property var colors: JSON.parse(colorsJson.text())


    property string theme: colors.theme
        property color primary: colors.primary
            property color secondary: colors.secondary
                property color light: colors.light
                    property color active: colors.active

                        LazyLoader {
                            loading: false
                            active: theme === "Default"
                            Default.Main {}
                        }

                        LazyLoader {
                            loading: false
                            active: theme === "Minecraft"
                            Minecraft.Main {}
                        }

                    }