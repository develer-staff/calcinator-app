import QtQuick 2.9
import QtQuick.Controls 2.4

Item {
    id: root

    signal changeTeam()

    property string playerName
    property color playerColor
    property url playerImage
    property int playerImageBorderWidth

    Rectangle {
        anchors.centerIn: parent
        width: parent.width - 2
        height: parent.height - 2
        border {
            width: playerImageBorderWidth
            color: playerColor
        }

        Image {
            anchors.centerIn: parent
            source: playerImage
            sourceSize {
                width: parent.width - playerImageBorderWidth
                height: parent.height - playerImageBorderWidth
            }
            MouseArea {
                anchors.fill: parent
                onClicked: root.changeTeam()
            }

            BusyIndicator {
                anchors.centerIn: parent
                running: parent.status === Image.Loading
            }

            Text {
                anchors.centerIn: parent
                text: root.playerName
                visible: parent.status === Image.Ready
            }
        }
    }

}
