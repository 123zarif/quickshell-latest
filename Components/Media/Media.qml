import "../"

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris



Item {
    id: mediaContainer
    Layout.preferredWidth: row.width
    Layout.fillHeight: true

    property string pic_url: ""



        RowLayout {
            id: row
            height: parent.height



            Repeater {
                model: Mpris.players


                Rectangle {
                    property bool showWidget: false
                        property bool mainHovering: false
                            property bool widgetHovering: false
                                property bool sliderHovering: false
                                    property bool prevHovering: false
                                        property bool playHovering: false
                                            property bool nextHovering: false

                                                id: rect
                                                Layout.preferredWidth: trackInfo.width > 200 ? 200 : trackInfo.width
                                                Layout.fillHeight: true
                                                color: secondary
                                                topLeftRadius: 100
                                                topRightRadius: 100
                                                bottomLeftRadius: showWidget ? 0: 100
                                                bottomRightRadius: showWidget ? 0: 100
                                                clip: true


                                                Timer {
                                                    id: graceTimer
                                                    interval: 50
                                                    running: false
                                                    repeat: false
                                                    onTriggered: {
                                                        if (mainHovering || widgetHovering || sliderHovering || prevHovering || playHovering || nextHovering)
                                                        {
                                                            showWidget = true
                                                        }
                                                        else {
                                                            showWidget = false
                                                        }
                                                    }
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true

                                                    onEntered: {
                                                        mainHovering = true
                                                        graceTimer.start()
                                                    }
                                                    onExited: {
                                                        mainHovering = false
                                                        graceTimer.start()

                                                    }
                                                }

                                                Spotify_Widget {
                                                player: modelData
                                                anchorTo: rect
                                            }

                                            Item {
                                                height: parent.height

                                                RowLayout {
                                                    id: trackInfo
                                                    width: implicitWidth > 200 ? 200 : implicitWidth
                                                    height: parent.height
                                                    spacing: 3

                                                    Icons {
                                                        name: modelData.identity == "Spotify" ? "spotify" : modelData.identity == "Mozilla firefox" ? "firefox" : "applications-multimedia"
                                                        overlay: false
                                                        size: 20
                                                        Layout.leftMargin: 10
                                                    }

                                                    Text {

                                                        id: trackTitle

                                                        Layout.fillWidth: true

                                                        text: modelData.trackTitle
                                                        font.pixelSize: 13
                                                        font.family: font_family
                                                        elide: Text.ElideRight
                                                        color: primary
                                                        font.bold: true
                                                        Layout.rightMargin: 10
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }