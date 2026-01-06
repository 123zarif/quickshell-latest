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
    property bool launcherWidgetVisible: false

        GlobalShortcut {
            name: "launcher_widget"
            description: "Toggles the launcher widget"
            onPressed: {
                launcherWidgetVisible = !launcherWidgetVisible
            }
        }

        LazyLoader {
            loading: false
            active: launcherWidgetVisible
            Launcher_Widget {}
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