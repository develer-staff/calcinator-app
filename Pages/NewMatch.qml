import QtQuick 2.0

GridView {
    id: root

    QtObject {
        id: teamId

        property int none: 0
        property int red: 1
        property int blue: 2

        function nextTeam(team) {
            return (team + 1)%(blue+1)
        }
    }

    QtObject {
        id: props
        property int borderMargin: 10
        property int imageMargin: 8
    }

    model: slackPhotos
    delegate: Item {
        width: root.cellWidth - props.imageMargin
        height: root.cellHeight - props.imageMargin

        Rectangle {
            anchors.centerIn: parent
            width: parent.width - 2
            height: parent.height - 2
            border {
                width: props.borderMargin
                color: {
                    if (team === teamId.none) {
                        return "transparent"
                    } else if (team === teamId.red) {
                        return "red"
                    }
                    return "blue"
                }
            }

            Image {
                anchors.centerIn: parent
                source: imageUrl
                sourceSize {
                    width: parent.width - props.borderMargin
                    height: parent.height - props.borderMargin
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
            }

            Text {
                text: name
                anchors.centerIn: parent
            }
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
