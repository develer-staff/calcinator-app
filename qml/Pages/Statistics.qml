import QtQuick 2.0
import QtQuick.Controls 2.5

import Components 1.0

import players 1.0

ListView {
    spacing: 5

    model: PlayersModel

    delegate: Item {
        anchors {
            left: parent.left
            right: parent.right

            margins: 10
        }

        height: 100

        Row {
            anchors.verticalCenter: parent.verticalCenter

            spacing: 15

            Item {

                width: 80
                height: width

                Image {
                    id: playerImage
                    anchors.centerIn: parent

                    source: picture
                    sourceSize {
                        width: parent.width - 6
                        height: parent.height - 6
                    }

                }
                BusyIndicator {
                    anchors.fill: parent
                    running: playerImage.status === Image.Loading
                }
            }

            Text {
                id: playerName

                anchors.verticalCenter: parent.verticalCenter

                text: name
                font.pixelSize: 16
            }

            StatInfo {
                anchors.verticalCenter: parent.verticalCenter

                imgSource: "qrc:/icons/honor"
                text: honorLost
            }

            StatInfo {
                anchors.verticalCenter: parent.verticalCenter

                imgSource: "qrc:/icons/won"
                text: won
            }

            StatInfo {
                anchors.verticalCenter: parent.verticalCenter

                imgSource: "qrc:/icons/lost"
                text: lost
            }
        }
    }
}
