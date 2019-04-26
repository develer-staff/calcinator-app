import QtQuick 2.11
import QtQuick.Controls 2.4

import Components 1.0

Column {
    id: root

    signal newMatch()
    signal statistics()

    spacing: 15

    Image {
        id: logo
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/icons/logo"
    }

    MenuItem {
        width: 300
        height: 80

        anchors.horizontalCenter: parent.horizontalCenter

        radius: 30

        txt: qsTr("Nuova partita")
        src: "qrc:/icons/play-button"
        buttonColor: "#03A9F4"

        onSelected: root.newMatch()
    }

    MenuItem {
        width: 300
        height: 80
        anchors.horizontalCenter: parent.horizontalCenter

        radius: 30

        txt: qsTr("Stats")
        src: "qrc:/icons/statistics"
        buttonColor: "#03A9F4"

        onSelected: root.statistics()
    }

    MenuItem {
        width: 300
        height: 80
        anchors.horizontalCenter: parent.horizontalCenter

        radius: 30

        txt: qsTr("Nuovo giocatore")
        src: "qrc:/icons/new-user"
        buttonColor: "#03A9F4"
    }
}
