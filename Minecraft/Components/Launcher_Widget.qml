import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
    property int crrIndex: 0
        property var sortedList: DesktopEntries.applications.values


            implicitHeight: screen.height
            exclusionMode: ExclusionMode.Ignore
            focusable: true

            color: "transparent"

            anchors {
                bottom: true
                left: true
                right: true
            }

            ColumnLayout {
                anchors.bottom: parent.bottom
                width: parent.width
                spacing: 3

                Rectangle {
                    width: 500
                    Layout.preferredHeight: sortedList.length > 0 ? launcherList.contentHeight + 20 : 0
                    Layout.maximumHeight: 400
                    color: '#dc000000'
                    Layout.leftMargin: 44

                    ListView {
                        id: launcherList
                        anchors.fill: parent
                        anchors.margins: 15
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                        spacing: 7
                        currentIndex: crrIndex
                        highlightMoveDuration: 300
                        clip: true
                        verticalLayoutDirection: ListView.BottomToTop
                        model: sortedList
                        delegate: Text {
                            text: modelData.name
                            font.pixelSize: 18
                            font.family: "Minecraft"
                            color: index === crrIndex ? "#FFFF00" : "white"
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    color: '#dc000000'

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 20
                        spacing: 5

                        Text {
                            text: "/"
                            color: "white"
                            font.pixelSize: 20
                            font.family: "Minecraft"
                        }
                        TextField {
                            id: pathInput
                            focus: true
                            font.pixelSize: 20
                            font.family: "Minecraft"
                            color: "white"
                            background: Rectangle {
                                color: "transparent"
                            }
                            Layout.fillWidth: true

                            onTextChanged: {
                                var filtered = DesktopEntries.applications.values.filter((item) => item.name.toLowerCase().includes(text.toLowerCase()));
                                sortedList = filtered;
                                crrIndex = 0;
                            }
                            Keys.onDownPressed: {

                                if (crrIndex > 0) crrIndex--
                                else
                                {
                                    crrIndex = launcherList.count - 1
                                }
                            }
                            Keys.onUpPressed: {
                                if (crrIndex < launcherList.count - 1) crrIndex++

                                else
                                {
                                    crrIndex = 0
                                }
                            }
                            Keys.onReturnPressed: {
                                if (sortedList.length > 0)
                                {
                                    launcherWidgetVisible = false
                                    sortedList[crrIndex].execute()
                                }
                            }
                            Keys.onEscapePressed: {
                                launcherWidgetVisible = false
                            }
                        }
                    }
                }
            }
        }