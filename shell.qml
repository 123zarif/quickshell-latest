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


    property color primary: colors.primary
        property color secondary: colors.secondary
            property color light: colors.light
                property color active: colors.active

                    Default.Main {}
                    Minecraft.Main {}

                }