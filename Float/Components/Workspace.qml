import "../../Global/"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
    property bool focused: {
        if (modelData.id >= 0)
        {
            modelData.focused
        }
        else
        {
            if (Hyprland.monitors && Hyprland.monitors.some)
            {
                Hyprland?.monitors?.some(m => m.activeSpecialWorkspace?.id === modelData.id)
            }else
            false
        }
    }



    function getIcon(appClass)
    {
        let name = (appClass?.wayland?.appId || "").toLowerCase();
        if (name.includes("brave"))
            return "\udb80\ude39";

        if (appClass.title.includes("nvim") || name.includes("code"))
            return "\uf121";

        if (name.includes("kitty"))
            return "\uf120";

        if (name.includes("discord") || name.includes("vesktop"))
            return "\uf1ff";

        if (name.includes("spotify"))
            return "\uf1bc";

        return "\uf444";
    }


    Layout.fillHeight: true
    Layout.preferredWidth: focused ? iconsRow.width + 60 : iconsRow.width + 15

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            modelData.activate()
        }
    }

    Rectangle {
        width: parent.width - 10
        height: parent.height - 12
        anchors.centerIn: parent
        color: focused ? secondary : "transparent"
        radius: 200

        RowLayout {
            id: iconsRow

            Layout.fillHeight: true
            Layout.preferredWidth: implicitWidth
            anchors.centerIn: parent
            spacing: 15

            Text {
                visible: modelData.toplevels.values.length < 1 ? true : false
                text: modelData.id
                font.pixelSize: 20
                color: focused ? primary : Colors.secondary
                font.family: Colors.font
            }

            Repeater {
                id: appRepeater

                model: modelData ? modelData.toplevels : null

                delegate: Text {
                    required property var modelData

                    text: getIcon(modelData)
                    font.pixelSize: 22
                    color: focused ? Colors.primary : Colors.secondary
                    font.family: Colors.font
                }

            }

        }
        Behavior on width {
        SpringAnimation {
            spring: 3.0   // How strongly it pulls toward the target width (higher = faster)
            damping: 0.1  // How much it bounces (lower = more bounce)
        }
    }

}

}
