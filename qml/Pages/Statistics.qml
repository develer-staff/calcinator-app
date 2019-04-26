import QtQuick 2.0
import QtQuick.Layouts 1.3

import players 1.0

Item {
    id: root

    ListView {
        anchors.fill: parent
        model: PlayersModel{}

        delegate: Item {
            anchors {
                left: parent.left
                right: parent.right

                margins: 10
            }

            height: 100

            RowLayout {
                spacing: 15

                Image {
                    id: playerImage
                    source: picture
                }

                Text {
                    id: playerName

                    text: name
                    font.pixelSize: 16
                }

                Column {
                    spacing: 2

                    Image {
                        id: honorIcon
                        anchors.horizontalCenter: parent.horizontalCenter

                        width: 20
                        height: width

                        source: "qrc:/icons/honor"
                    }

                    Text {
                        id: honorLost
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: "4"
                        font.pixelSize: 16
                    }
                }

                Column {
                    spacing: 2

                    Image {
                        id: wonIcon
                        anchors.horizontalCenter: parent.horizontalCenter

                        width: 20
                        height: width

                        source: "qrc:/icons/won"
                    }

                    Text {
                        id: wonText
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: "15"
                        font.pixelSize: 16
                    }
                }

                Column {
                    spacing: 2

                    Image {
                        id: lostIcon
                        anchors.horizontalCenter: parent.horizontalCenter

                        width: 20
                        height: width

                        source: "qrc:/icons/lost"
                    }

                    Text {
                        id: lostText
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: "7"
                        font.pixelSize: 16
                    }
                }
            }
        }
    }
}
