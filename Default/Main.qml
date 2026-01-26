import "./Components"

import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
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