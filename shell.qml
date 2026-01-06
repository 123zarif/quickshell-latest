import "./Components"
import "./Components/Media"
import "./Components/Bluetooth"
import "./Components/Sound"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland


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


                    property bool launcherWidgetVisible: false
                        property bool themeWidgetVisible: false

                            GlobalShortcut {
                                name: "launcher_widget"
                                description: "Toggles the launcher widget"
                                onPressed: {
                                    launcherWidgetVisible = !launcherWidgetVisible
                                }
                            }
                            GlobalShortcut {
                                name: "theme_widget"
                                description: "Open theme switcher"
                                onPressed: {
                                    themeWidgetVisible = !themeWidgetVisible
                                }
                            }

                            LazyLoader {
                                loading: false
                                active: launcherWidgetVisible
                                Launcher_Widget {}
                            }
                            LazyLoader {
                                loading: false
                                active: themeWidgetVisible
                                Theme_Widget {}
                            }

                            Scope {
                                Variants {
                                    model: Quickshell.screens

                                    delegate: Component {

                                        Panel {}
                                    }

                                }
                            }
                        }