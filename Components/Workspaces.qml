import Quickshell
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Layouts

RowLayout {
    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: 2

    Repeater {
        model: 10

        Rectangle {
            property bool focused: modelData + 1 === Hyprland?.focusedWorkspace?.id ? true: false

            color: workspaceMouseArea.containsMouse ? "#373737": "transparent"
            Layout.fillHeight: true
            Layout.preferredWidth: focused ? 130: (
                (Hyprland && Hyprland.focusedWorkspace && (modelData === Hyprland.focusedWorkspace.id - 2 || modelData === Hyprland.focusedWorkspace.id))
                || workspaceMouseArea.containsMouse
            ) ? 60: 15
            clip: true

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 60
                height: 4
                width: parent.width
                color: focused || workspaceMouseArea.containsMouse ? secondary: light
                anchors.bottomMargin: focused ? 3: 0
            }

            MouseArea {
                id: workspaceMouseArea

                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    modelData + 1 !== Hyprland.focusedWorkspace.id && (Hyprland.dispatch(`workspace ${modelData + 1}`));
                }
            }

            Behavior on Layout.preferredWidth {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }

        }

    }

}

}