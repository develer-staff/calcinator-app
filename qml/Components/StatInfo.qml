import QtQuick 2.0

Column {
    id: root

    property url imgSource
    property string text

    spacing: 2

    Image {
        id: honorIcon
        anchors.horizontalCenter: parent.horizontalCenter

        width: 20
        height: width

        source: root.imgSource
    }

    Text {
        id: honorLost
        anchors.horizontalCenter: parent.horizontalCenter

        text: root.text
        font.pixelSize: 16
    }
}
