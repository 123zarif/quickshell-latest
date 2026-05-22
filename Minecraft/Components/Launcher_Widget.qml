import "../../Global"

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import QtQuick.Effects

PanelWindow {
    id: panel

    property int crrIndex: 0
        property string crrText: ""
            property var sortedList: []
            property var sorts: [
            {name: "All", active: false, formula: function (data) { return true }},
            {name: "Android Apps", active: false, formula: function (data) { return (data.categories.includes("X-WayDroid-App") && !data.categories.includes("Utility")) }},
            {name: "Desktop Apps", active: true, formula: function (data) { return (!(data.categories.includes("X-WayDroid-App") && !data.categories.includes("Utility"))) }}
            ]


            function filterApps ()
            {
                if (crrText === "")
                {
                    sortedList = []
                    return true;
                }
                sortedList = DesktopEntries.applications.values.filter(itm => {


                let matchesSearch = itm.name.toLowerCase().includes(crrText);
                if (!matchesSearch) return false;

                for (var i = 0; i < sorts.length; i++) {
                    if (sorts[i].active)
                    {
                        let check = sorts[i].formula(itm)
                        if (!check) return false;
                    }
                }
                return true;
            })
        }


        exclusionMode: ExclusionMode.Ignore
        focusable: true
        color: "transparent"

        anchors {
            bottom: true
            top: true
            left: true
            right: true
        }

        Timer {
            interval: 150
            running: true
            repeat: false
            onTriggered: {
                main.scale = 1
                main.opacity = 1
            }
        }

        Rectangle {
            width: 700
            height: 400
            color: "transparent"
            anchors.centerIn: parent
            Rectangle {
                id: main
                width: parent.width
                height: mainLayout.implicitHeight + 20
                color: Qt.rgba(0.05, 0.05, 0.06, 0.8)
                border.color: Qt.rgba(1.0, 1.0, 1.0, 0.2)
                border.width: 1.5
                radius: 30
                clip: true

                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: "#000000"
                    shadowOpacity: 0.7
                    shadowBlur: 1.0
                    shadowVerticalOffset: 10
                    shadowHorizontalOffset: 10 // Push the shadow slightly down
                }

                scale: 0.0
                opacity: 0.0


                Behavior on scale {
                SpringAnimation {
                    spring: 7
                    damping: 0.3
                    epsilon: 0.001
                }
            }

            Behavior on height {
            NumberAnimation {
                duration: 350
                easing.type: Easing.InOutQuad
            }
        }

        ColumnLayout {
            id: mainLayout

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: 10
            anchors.margins: 15
            anchors.topMargin: 10



            RowLayout {
                Layout.fillWidth: true

                Icons {
                    id: arch
                    name: "search"
                    iconColor: "#F2F4F8"
                    size: 25
                }

                TextField {
                    id: searchField
                    Layout.fillWidth: true

                    focus: true

                    Keys.onUpPressed: {
                        if (crrIndex > 0) crrIndex -= 1
                    }
                    Keys.onDownPressed: {
                        if (sortedList.length > crrIndex + 1) crrIndex += 1
                    }

                    Keys.onReturnPressed: {
                        if (sortedList.length > 0)
                        {
                            launcherWidgetVisible = false
                            sortedList[crrIndex].execute()
                        }
                    }

                    font.pixelSize: 24
                    leftInset: -10
                    color: "#F2F4F8"

                    placeholderText: "Search applications..."
                    placeholderTextColor: Qt.rgba(1.0, 1.0, 1.0, 0.5)
                    background: Rectangle {
                        color: "transparent"

                        border.width: 0
                        radius: 5
                    }

                    onTextChanged: {
                        crrText = text.toLowerCase()
                        crrIndex = 0
                        filterApps()
                    }
                }
            }

            Rectangle {
                color: primary
                visible: sortedList.length > 0
                Layout.fillWidth: true
                Layout.preferredHeight: 2
            }


            ListView {
                id: launcherList

                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(contentHeight, 550)

                visible: sortedList.length > 0

                spacing: 3
                currentIndex: crrIndex
                highlightMoveDuration: 300
                clip: true
                model: sortedList


                delegate: Rectangle {
                    height: 65
                    width: launcherList.width
                    color: crrIndex == index ? "#4D88C0D0" : "transparent"
                    radius: 16

                    RowLayout {
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter

                        IconImage {
                            Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
                            implicitSize: 40
                            source: Quickshell.iconPath(modelData.icon)
                            Layout.leftMargin: 10
                        }

                        Text {
                            text: modelData.name
                            font.pixelSize: 20
                            font.weight: 900
                            font.family: Colors.font
                            color: crrIndex == index ? "#88C0D0" : "#F2F4F8"
                        }
                    }
                }
            }

        }
    }

}
}