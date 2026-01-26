import "./Components"

import Quickshell
import Quickshell.Hyprland
import QtQuick

Item {
    property bool launcherWidgetVisible: false

        GlobalShortcut {
            name: "launcher_widget"
            description: "Toggles the launcher widget"
            onPressed: {
                launcherWidgetVisible = !launcherWidgetVisible
            }
        }

        // LazyLoader {
        //     loading: false
        //     active: launcherWidgetVisible
        //     Launcher_Widget {}
        // }

        Scope {
            Variants {
                model: Quickshell.screens

                // delegate: Component {

                // }

            }
        }
    }