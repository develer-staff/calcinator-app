import QtQuick 2.0
import QtQuick.Controls 2.4

import Components 1.0

import players 1.0

GridView {
    id: root

    QtObject {
        id: props
        property int borderMargin: 10
        property int imageMargin: 8
    }

    cellHeight: width/4
    cellWidth: width/4

    model: PlayersModel {
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
    }
}
