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
    Layout.preferredWidth: focused ? iconsRow.width + 55 : iconsRow.width + 35

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            modelData.activate()
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height - 15
        anchors.centerIn: parent
        color: focused ? secondary : Qt.alpha(secondary, 0.3)
        radius: 200

        RowLayout {
            id: iconsRow

            Layout.fillHeight: true
            Layout.preferredWidth: implicitWidth
            anchors.centerIn: parent
            spacing: 20

            Text {
                visible: modelData.toplevels.values.length < 1 ? true : false
                text: modelData.id
                font.pixelSize: 19
                color: focused ? primary : secondary
                font.family: Colors.font
            }

            Repeater {
                id: appRepeater

                model: modelData ? modelData.toplevels : null

                delegate: Text {
                    required property var modelData

                    text: getIcon(modelData)
                    font.pixelSize: 19
                    color: focused ? Colors.primary : Qt.tint("#FFFFFF", Qt.alpha(primary, 0.2))
                    font.family: Colors.font
                }

            }

        }

        Behavior on width {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutExpo
        }
    }

}

}
