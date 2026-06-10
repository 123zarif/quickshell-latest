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
            ListModel { id: filteredModel }
            property var sortedList: []
            property var sorts: [
            {name: "All", active: false, formula: function (data) { return true }},
            {name: "Android Apps", active: false, formula: function (data) { return (data.categories.includes("X-WayDroid-App") && !data.categories.includes("Utility")) }},
            {name: "Desktop Apps", active: true, formula: function (data) { return (!(data.categories.includes("X-WayDroid-App") && !data.categories.includes("Utility"))) }}
            ]

            function filterApps()
            {

                let allApps = DesktopEntries.applications.values;
                let matches = [];


                // 1. Gather all actual matching application objects
                if (crrText !== "")
                {
                    for (let i = 0; i < allApps.length; i++) {
                        let itm = allApps[i];
                        if (!itm.name.toLowerCase().includes(crrText)) continue;

                        let passesCategory = true;
                        for (let s = 0; s < sorts.length; s++) {
                            if (sorts[s].active && !sorts[s].formula(itm))
                            {
                                passesCategory = false;
                                break;
                            }
                        }

                        if (passesCategory)
                        {
                            matches.push(itm);
                        }
                    }
                }

                // 2. Remove items from the visual list that no longer match the search
                for (let i = filteredModel.count - 1; i >= 0; i--) {
                    let modelApp = filteredModel.get(i).app;
                    if (!matches.includes(modelApp))
                    {
                        filteredModel.remove(i, 1);
                    }
                }

                // 3. Insert or Move matching items into their correct visual positions
                for (let i = 0; i < matches.length; i++) {
                    let targetApp = matches[i];

                    // If the item is already exactly where it should be, skip it
                    if (i < filteredModel.count && filteredModel.get(i).app === targetApp)
                    {
                        continue;
                    }

                    // Check if the item exists further down the list
                    let foundIndex = -1;
                    for (let j = i + 1; j < filteredModel.count; j++) {
                        if (filteredModel.get(j).app === targetApp)
                        {
                            foundIndex = j;
                            break;
                        }
                    }

                    if (foundIndex !== -1)
                    {
                        // It exists, move it upward! (This naturally triggers the 'displaced' transition)
                        filteredModel.move(foundIndex, i, 1);
                    } else {
                    // It's a brand new match, insert it! (This triggers the 'add' transition)
                    filteredModel.insert(i, { "app": targetApp });
                }
            }
        }

        exclusionMode: ExclusionMode.Ignore
        focusable: true
        color: '#28000000'

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
                border.color: Qt.rgba(1, 1, 1, 0.32)
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
                duration: 250
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
                        if (filteredModel.count > crrIndex + 1) crrIndex += 1
                    }

                    Keys.onReturnPressed: {
                        if (filteredModel.count > 0)
                        {
                            launcherWidgetVisible = false
                            // Call execute() directly on the stored object
                            filteredModel.get(crrIndex).app.execute()
                        }
                    }
                    Keys.onEscapePressed: {
                        launcherWidgetVisible = false
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

                // 1. Create a property to calculate the height we WANT to be
                property real targetHeight: Math.min(contentHeight, 550)

                // 2. Bind the layout's actual height to our new property
                Layout.fillWidth: true
                Layout.preferredHeight: targetHeight

                // 3. Animate this property to match the 'displaced' transition EXACTLY
                Behavior on targetHeight {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutQuart
                }
            }

            visible: filteredModel.count > 0
            spacing: 3
            currentIndex: crrIndex
            highlightMoveDuration: 300
            clip: true
            model: filteredModel

            displaced: Transition {
                NumberAnimation {
                    properties: "x, y"
                    duration: 250
                    easing.type: Easing.OutQuart
                }
            }

            add: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }
            }

            remove: Transition {
                NumberAnimation {
                    property: "opacity"
                    to: 0
                    duration: 150
                }
            }

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
                        // Access the icon straight from the model's stored app object
                        source: Quickshell.iconPath(model.app.icon)
                        Layout.leftMargin: 10
                    }

                    Text {
                        // Access the name straight from the model's stored app object
                        text: model.app.name
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