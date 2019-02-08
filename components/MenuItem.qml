import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root

    property url src
    property string txt
    property string buttonColor

    signal selected()

    color: root.buttonColor

    Column {
        anchors.centerIn: parent

        width: root.width
        spacing: 5

        Image {
            id: img

            anchors.horizontalCenter: parent.horizontalCenter
            width: 40
            height: width

            source: root.src
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.txt
            font.bold: true
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            selected()
        }
    }
}
