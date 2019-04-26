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
        id: teamRect
        anchors.centerIn: parent
        width: parent.width - 2
        height: parent.height - 2
        border {
            width: playerImageBorderWidth
            color: playerColor

            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }

        Column {
            id: imageNameCol
            anchors.centerIn: parent
            spacing: 5

            Image {
                id: playerImg
                source: playerImage
                sourceSize {
                    width: teamRect.width - playerImageBorderWidth
                    height: teamRect.height - playerImageBorderWidth
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: playerImg.status === Image.Ready ? root.playerName : ""
            }
        }

        BusyIndicator {
            anchors.centerIn: imageNameCol
            running: playerImg.status === Image.Loading
        }

        MouseArea {
            anchors.fill: imageNameCol
            onClicked: root.changeTeam()
        }
    }

    states:
        State {
            id: imageReady
            when: playerImg.status == Image.Ready
        }

    transitions:
        Transition {
            SequentialAnimation {
                PropertyAnimation {
                    duration: 0
                    target: imageNameCol
                    property: "opacity"
                    to: 0
                }

                PauseAnimation {
                    duration: 500
                }

                PropertyAnimation {
                    duration: 300
                    target: imageNameCol
                    property: "opacity"
                    to: 1
                }
            }
        }


}
