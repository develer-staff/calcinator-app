import QtQuick 2.0

GridView {
    id: root

    QtObject {
        id: teamId

        //        property list colors: [none, red, blue]
        property int none: 0
        property int red: 1
        property int blue: 2

        function nextTeam(team) {
            return (team + 1)%(blue+1)
        }
    }

    model: slackPhotos
    delegate: Rectangle {
        width: root.cellWidth
        height: root.cellHeight
        Image {
            source: imageUrl
            sourceSize {
                width: root.cellWidth
                height: root.cellHeight
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var nextTeam = teamId.nextTeam(team)
                    while (nextTeam !== teamId.none && slackPhotos.getTeamMembers(nextTeam) === 2) {
                        nextTeam = teamId.nextTeam(nextTeam)
                    }

                    team = nextTeam
                    return
                }
            }
            Rectangle {
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                }

                width: 10
                height: 10
                color: {
                    if (team === teamId.none) {
                        return "transparent"
                    } else if (team === teamId.red) {
                        return "red"
                    }
                    return "blue"
                }
            }
        }

        Text {
            text: name
            anchors.centerIn: parent
        }
    }
    cellHeight: width/4
    cellWidth: width/4

    ListModel {
        id: slackPhotos
        function getTeamMembers(color) {
            var found = 0;
            for (var i=0; i<slackPhotos.count;i++) {
                if (color === slackPhotos.get(i).team) {
                    found++;
                    if (found === 2) {
                        break;
                    }
                }

            }
            return found;
        }
    }

    Component.onCompleted: {
        for (var i=0; i<30; i++) {
            slackPhotos.append({"imageUrl": "https://i1.wp.com/vanillicon.com/9f33b3cf22a2ee42f4962d7ba9703c2c_200.png", "name": "bara_%1".arg(i), "team": teamId.none});
        }
    }
}
