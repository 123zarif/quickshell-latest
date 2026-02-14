import "../"

import QtQuick
import QtQuick.Layouts
import Quickshell

ColumnLayout {

    readonly property var monthNames: [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]

    readonly property var today: new Date()


    property var date: today
        property int year: date.getFullYear()
        property int month: date.getMonth()

        readonly property var calendarData: {
            const firstDay = new Date(year, month, 1).getDay();
            const daysInMonth = new Date(year, month + 1, 0).getDate();

            let days = [];
            for (let i = 0; i < firstDay; i++) {
                days.push("");
            }

            for (let i = 1; i <= daysInMonth; i++) {
                days.push(i.toString());
            }
            return days;
        }

        function changePrev()
        {
            if (month < 1)
            {
                year -= 1;
                month = 11;
            }
            else
            {
                month -= 1;
            }
        }

        function changeNext()
        {
            if (month > 10)
            {
                year += 1;
                month = 0;
            }
            else
            {
                month += 1;
            }
        }

        width: parent.width
        implicitHeight: dayList.Layout.preferredHeight + datesGrid.Layout.preferredHeight + info.implicitHeight + 20

        RowLayout {
            id: info
            Layout.alignment: Qt.AlignCenter
            Layout.margins: 10
            spacing: 15

            Rectangle {
                width: prev.implicitWidth + 20
                height: prev.implicitHeight + 5
                color: primary
                radius: 200

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: false

                    onClicked: {
                        changePrev()
                    }
                }

                Text {
                    anchors.centerIn: parent
                    id: prev
                    text: "<"
                    color: secondary
                    font.pixelSize: 23
                    font.bold: true
                }
            }

            Text {
                text: monthNames[month] + " " + year
                color: primary
                font.pixelSize: 20
                font.bold: true
            }

            Rectangle {
                width: prev.implicitWidth + 20
                height: prev.implicitHeight + 5
                color: primary
                radius: 200

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: false

                    onClicked: {
                        changeNext()
                    }
                }

                Text {
                    anchors.centerIn: parent
                    id: next
                    text: ">"
                    color: secondary
                    font.pixelSize: 23
                    font.bold: true
                }
            }
        }

        ListView {
            id: dayList

            Layout.fillWidth: true
            Layout.preferredHeight: 20
            orientation: ListView.Horizontal

            model: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            delegate: Rectangle {
                height: dayList.height
                width: dayList.width / 7

                color: "transparent"

                Text {
                    anchors.centerIn: parent
                    text: modelData
                    color: primary
                    font.pixelSize: 17
                    font.bold: true
                }
            }
        }

        GridView {
            id: datesGrid
            cellWidth: parent.width / 7
            cellHeight: 50
            Layout.fillWidth: true
            Layout.preferredHeight: Math.ceil(calendarData.length / 7) * cellHeight
            clip: true
            model: calendarData

            delegate: Rectangle {
                readonly property bool isToday: today.getDate() == modelData && today.getMonth()== month && today.getFullYear() == year

                    height: datesGrid.cellHeight
                    width: datesGrid.cellWidth

                    color: "transparent"

                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width - 30
                        height: parent.height - 10
                        radius: 300

                        color: isToday ? primary : "transparent"
                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            color: isToday ? secondary : primary
                            font.pixelSize: 18
                        }
                    }
                }
            }
        }