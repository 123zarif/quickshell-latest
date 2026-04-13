import "./Default" as Default
import "./Float/" as Float
import "./Global/"
import "./Minecraft" as Minecraft
import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
    id: shellroot

    property string theme: Colors.theme
        property color primary: Colors.primary
            property color secondary: Colors.secondary
                property color light: Colors.light
                    property color active: Colors.active
                        property string font: "JetBrains Mono Nerd Font"

                            FileView {
                                id: colorsJson

                                path: Qt.resolvedUrl("./persists/colors.json")
                                blockLoading: true
                            }

                            LazyLoader {
                                loading: false
                                active: Colors.theme === "Default"

                                Default.Main {
                                }

                            }

                            LazyLoader {
                                loading: false
                                active: Colors.theme === "Minecraft"

                                Minecraft.Main {
                                }

                            }

                            LazyLoader {
                                loading: false
                                active: Colors.theme === "Float"

                                Float.Main {
                                }

                            }

                        }
