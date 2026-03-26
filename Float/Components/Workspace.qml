import "../../Global/"
import QtQuick
import QtQuick.Layouts
import Quickshell

Item {
    property bool focused: modelData.focused

    function getIcon(appClass) {
        let name = (appClass.wayland.appId || "").toLowerCase();
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

    height: workspaces.height
    width: iconsRow.width

    Rectangle {
        width: iconsRow.width + 20
        height: parent.height - 10
        anchors.centerIn: parent
        color: focused ? Colors.secondary : "transparent"
        radius: 200

        RowLayout {
            id: iconsRow

            height: parent.height
            width: implicitWidth
            anchors.centerIn: parent

            Repeater {
                id: appRepeater

                model: modelData ? modelData.toplevels : null

                delegate: Text {
                    required property var modelData

                    text: getIcon(modelData)
                    font.pixelSize: 20
                    color: focused ? Colors.primary : Colors.secondary
                    font.family: Colors.font
                }

            }

        }

    }

}
