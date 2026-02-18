import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls

ScrollView {
    property var times: {
        let arr = [];

        for (let i = 1; i < 12; i++) {
            arr.push(`${String(i).padStart(2, '0')}:00 am`)
        }
        arr.push("12:00pm")
        for (let i = 1; i < 12; i++) {
            arr.push(`${String(i).padStart(2, '0')}:00 pm`)
        }


        return arr;
    }

    Layout.fillHeight: true
    Layout.preferredWidth: 300
    hoverEnabled: false


    RowLayout {
        Layout.fillHeight: true
        Layout.fillWidth: true

        ColumnLayout {
            Layout.fillHeight: true
            Layout.preferredWidth: 100
            Repeater {
                id: timeList
                model: times

                Rectangle {
                    color: "transparent"

                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100
                    border.width: 3
                    Text {
                        id: timeText
                        text: modelData
                        color: primary
                        font.bold: true
                        font.pixelSize: 20
                    }
                }
            }
        }


        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            ColumnLayout {
                width:parent.width

                Repeater {
                    id: eventList
                    model: [{name: "English", duration: 2}]
                    // Layout.fillHeight: true
                    // Layout.fillWidth: true


                    Rectangle {
                        color: "#fff"

                        // Layout.fillWidth: true
                        // width: 10

                        Layout.fillWidth: true
                        Layout.preferredHeight: modelData.duration * 100

                        Text {
                            id: timeText
                            text: modelData.name
                            color: primary
                            font.bold: true
                            font.pixelSize: 20
                        }
                    }
                }
            }
        }
    }
}