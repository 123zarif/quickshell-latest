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
    width: iconsRow.width + 15

    Rectangle {
        width: parent.width
        height: parent.height - 10
        anchors.centerIn: parent
        color: focused ? Colors.secondary : "transparent"
        radius: 200

        RowLayout {
            id: iconsRow

            Layout.fillHeight: true
            Layout.preferredWidth: implicitWidth
            anchors.centerIn: parent

            Text {
                visible: modelData.toplevels.values.length < 1 ? true : false
                text: modelData.id
                font.pixelSize: 20
                color: focused ? Colors.primary : Colors.secondary
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

    }

}
