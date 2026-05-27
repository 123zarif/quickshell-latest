import Quickshell
import QtQuick
import Quickshell.Io
pragma Singleton

Item {
    property var colors: null
        property string theme: "#000"
            property color primary: "#000"
                property color secondary: "#000"
                    property color light: "#000"
                        property color active: "#000"
                            property string font: "JetBrains Mono Nerd Font"

                                Component.onCompleted: {
                                    colors = JSON.parse(colorsJson.text());
                                    theme = colors.theme;
                                    primary = colors.primary;
                                    secondary = colors.secondary;
                                    light = colors.light;
                                    active = colors.active;
                                }

                                FileView {
                                    id: colorsJson

                                    path: Quickshell.env("HOME") + "/.config/quickshell/persists/colors.json"
                                    blockLoading: true
                                }

                            }
