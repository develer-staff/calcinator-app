import QtQuick 2.0
import QtQuick.Controls 2.4

import Components 1.0

import players 1.0

GridView {
    id: root

    clip: true
    interactive: !playersModel.updating

    cellHeight: width/4
    cellWidth: width/4

    onContentYChanged: {
        if (contentY < -90)
        {
            contentY = -90
            if (!updateTimer.running)
                updateTimer.start()
        } else if (!draggingVertically && contentY > -90) {
            updateTimer.stop()
        }
    }

    QtObject {
        id: props
        property int borderMargin: 10
        property int imageMargin: 8
    }

    Timer {
        id: updateTimer
        interval: 500
        running: false

        onTriggered: playersModel.update()
    }

    header: Item {
        anchors {
            left: parent.left
            right: parent.right
        }
        height: playersModel.updating ? 50 : 0

        Behavior on height {
            NumberAnimation {
                duration: 100
            }
        }

        BusyIndicator {
            anchors.centerIn: parent
            width: height
            height: parent.height
        }
    }

    model: PlayersModel {
        id: playersModel
    }

    delegate: PlayerSelectionButton {
        width: root.cellWidth - props.imageMargin
        height: root.cellHeight - props.imageMargin
        playerColor: {
            if (team === PlayersModel.None)
                return "transparent"
            else if (team === PlayersModel.Red)
                return "red"
            return "blue"
        }

        playerImage: picture
        playerImageBorderWidth: props.borderMargin

        onChangeTeam: playersModel.changeTeam(id)
    }
}
