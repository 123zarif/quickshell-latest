import "./Components"
import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
    id: main

    property bool launcherWidgetVisible: false
    property bool themeWidgetVisible: false

    GlobalShortcut {
        name: "launcher_widget"
        description: "Toggles the launcher widget"
        onPressed: {
            main.launcherWidgetVisible = !main.launcherWidgetVisible;
        }
    }

    GlobalShortcut {
        name: "theme_widget"
        description: "Open theme switcher"
        onPressed: {
            main.themeWidgetVisible = !main.themeWidgetVisible;
        }
    }

    LazyLoader {
        loading: false
        active: main.launcherWidgetVisible

        Launcher_Widget {
        }

    }

    LazyLoader {
        loading: false
        active: main.themeWidgetVisible

        Theme_Widget {
        }

    }

    Scope {
        Variants {
            model: Quickshell.screens

            delegate: Component {
                Panel {
                }

            }

        }

    }

}
