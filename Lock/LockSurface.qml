import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland
import Quickshell.Io
import QtQuick.Effects

Rectangle {
    id: root
    color: '#000'

    required property LockContext context
    readonly property ColorGroup colors: Window.active ? palette.active: palette.inactive

        property string wallpaperPath: ""

            Process {
                id: wallpaperFetcher
                command: ["sh", "-c", "awww query"]
                running: true

                stdout: SplitParser {

                    onRead: (text) => {
                    var parts = text.trim().split("image:")
                    if (parts.length >= 2)
                    {
                        wallpaperPath = parts[1].trim()
                    }
                }
            }
        }


        Image {
            id: bgImage
            source: wallpaperPath
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }

        MultiEffect {
            source: bgImage
            anchors.fill: bgImage
            blurEnabled: true
            blurMax: 64
            blur: 0.7
        }

        Rectangle {
            anchors.fill: parent
            color: '#69000000'
        }


        SystemClock {
            id: clock

            precision: SystemClock.Minutes
        }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 30

            ColumnLayout {
                spacing: 0
                Text {
                    color: "#fff"
                    text: Qt.formatDateTime(clock.date, "hh: mm AP")
                    font.pixelSize: 60
                    font.family: "serif"
                    font.weight: 700
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                Text {
                    color: "#fff"
                    text: Qt.formatDateTime(clock.date, "dddd, dd MMMM yyyy")
                    font.pixelSize: 32
                    font.family: "serif"
                    font.weight: 600
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                }
            }
            TextField {
                id: passwordField
                Layout.alignment: Qt.AlignHCenter
                echoMode: TextInput.Password
                placeholderText: "Enter your password"
                font.pixelSize: 24
                color: "#000"
                width: 500

                background: Rectangle {
                    anchors.centerIn: parent
                    width: 500
                    height: 45
                    color: '#f4f6f7'
                    radius: 30
                }


                onTextChanged: {
                    context.currentText = text;
                }

                Keys.onReturnPressed: {
                    context.tryUnlock();
                }
            }
        }
    }
