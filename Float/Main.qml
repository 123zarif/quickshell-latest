import "./Components"
import "./Components/System_Widget"
import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
    id: main

    property bool launcherWidgetVisible: false
        property bool themeWidgetVisible: false
            property bool systemWidgetVisible: false

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
                GlobalShortcut {
                    name: "system_widget"
                    description: "Toggles the system widget"
                    onPressed: {
                        main.systemWidgetVisible = !main.systemWidgetVisible
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

        LazyLoader {
            loading: false
            active: main.systemWidgetVisible

            System_Widget {
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
