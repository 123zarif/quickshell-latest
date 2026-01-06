import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland


PanelWindow {
    property string crrText: ""
        property int selectedIndex: 0
            property var sortedApps: filterApps()

            property var sorts: [
            {name: "All", active: false, formula: function (data) { return true }},
            {name: "Android Apps", active: false, formula: function (data) { return (data.categories.includes("X-WayDroid-App") && !data.categories.includes("Utility")) }},
            {name: "Desktop Apps", active: true, formula: function (data) { return (!(data.categories.includes("X-WayDroid-App") && !data.categories.includes("Utility"))) }}
            ]


            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

            id: laucnherPopup
            visible: true
            color: '#62000000'

            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            implicitHeight: screen.height
            implicitWidth: screen.width


            function filterApps ()
            {
                sortedApps = DesktopEntries.applications.values.filter(itm => {


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



        Timer {
            interval: 0
            running: launcherWidgetVisible
            repeat: false
            onTriggered: {
                main.visible = true
                main.opacity = 1
                searchField.forceActiveFocus()
            }
        }


        Rectangle {
            id: main
            anchors.centerIn: parent
            width: 1000
            height: 600
            color: '#c9000000'
            radius: 40
            visible: false
            opacity: 0

            Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.InQuad
            }
        }


        Rectangle {
            id: inside
            anchors.centerIn: parent
            color: "transparent"
            width: parent.width - 70
            height: parent.height - 50
            visible: !(main.height < 600 && main.width < 1000)

            ColumnLayout {
                width: parent.width
                height: parent.height
                spacing: 20

                TextField {
                    id: searchField
                    Layout.fillWidth: true
                    height: 30
                    Keys.onUpPressed: {
                        if (selectedIndex - 3 >= 0) selectedIndex -= 3
                    }
                    Keys.onDownPressed: {
                        if (selectedIndex + 3 < sortedApps.length) selectedIndex += 3
                    }
                    Keys.onLeftPressed: {
                        if (selectedIndex > 0) selectedIndex -= 1
                    }
                    Keys.onRightPressed: {
                        if (selectedIndex + 1 < sortedApps.length ) selectedIndex += 1
                    }
                    Keys.onReturnPressed: {
                        if (sortedApps.length > 0)
                        {
                            launcherWidgetVisible = false
                            sortedApps[selectedIndex].execute()
                        }
                    }
                    font.pixelSize: 20
                    leftInset: -10
                    bottomInset: -5
                    topInset: -5
                    color: "#fff"

                    placeholderText: "Search applications..."
                    placeholderTextColor: '#b2b2b2'
                    background: Rectangle {
                        color: "transparent"
                        border.color: "#fff"
                        border.width: 2
                        radius: 5
                    }

                    onTextChanged: {
                        crrText = text.toLowerCase()
                        selectedIndex = 0
                        filterApps()
                    }
                }




                ListView {
                    id: filter
                    model: sorts
                    Layout.fillWidth: true
                    height: 30
                    orientation: ListView.Horizontal
                    spacing: 10


                    delegate: Rectangle {
                        height: filter.height
                        width: sortName.width + 20
                        radius: 100
                        color: modelData.active ? '#3f47f1' : '#767676'

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                for (let i = 0; i < sorts.length; i++) {
                                    sorts[i].active = i === index ? true : false
                                }
                                filterApps()
                                modelData.active = sorts[index].active

                                filter.model = sorts


                            }
                        }


                        Text {
                            id: sortName
                            text: modelData.name
                            color: "#fff"
                            font.pixelSize: 16
                            anchors.centerIn: parent
                        }
                    }
                }



                ScrollView {
                    id: scrollView
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    GridLayout {
                        id: grid
                        width: scrollView.availableWidth
                        height: parent.height
                        columns: 3
                        rowSpacing: 25
                        columnSpacing: 10

                        Repeater {
                            model: sortedApps


                            Item {
                                width: grid.width / grid.columns - grid.columnSpacing * (grid.columns - 1)
                                height: 140

                                Rectangle {
                                    color: selectedIndex === index || mouseArea.containsMouse ? '#fff': "transparent"
                                    opacity: selectedIndex === index || mouseArea.containsMouse ? 0.15: 0
                                    width: parent.width
                                    height: parent.height

                                    Behavior on opacity {
                                    NumberAnimation {
                                        duration: 300
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                            }
                            Rectangle {
                                color: "transparent"
                                width: parent.width
                                height: parent.height

                                MouseArea {
                                    id: mouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor

                                    onClicked: {
                                        launcherWidgetVisible = false
                                        modelData.execute()
                                    }
                                }

                                ColumnLayout {
                                    id: column
                                    spacing: 0
                                    anchors.fill: parent
                                    anchors.centerIn: parent

                                    IconImage {
                                        Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
                                        implicitSize: selectedIndex === index || mouseArea.containsMouse ? 85: 60
                                        source: Quickshell.iconPath(modelData.icon)

                                        Behavior on implicitSize {
                                        NumberAnimation {
                                            duration: 150
                                            easing.type: Easing.InOutQuad
                                        }
                                    }
                                }
                                Text {
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillWidth: true
                                    Layout.margins: 5
                                    horizontalAlignment: Text.AlignHCenter
                                    text: modelData.name
                                    elide: Text.ElideRight
                                    color: "#fff"
                                    font.weight: 700
                                    font.pixelSize: selectedIndex === index || mouseArea.containsMouse ? 22: 20

                                    Behavior on font.pixelSize {
                                    NumberAnimation {
                                        duration: 150
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}
}
}
}