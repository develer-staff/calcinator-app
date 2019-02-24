import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import Components 1.0

Page {
    id: root

    signal newMatch()

    contentItem: ColumnLayout {
        spacing: 0

        MenuItem {
            Layout.fillWidth: true
            Layout.fillHeight: true

            txt: qsTr("Nuova partita")
            src: "qrc:/icons/play-button"
            buttonColor: "red"

            onSelected: root.newMatch()
        }

        MenuItem {
            Layout.fillWidth: true
            Layout.fillHeight: true

            txt: qsTr("Stats")
            src: "qrc:/icons/statistics"
            buttonColor: "yellow"
        }

        MenuItem {
            Layout.fillWidth: true
            Layout.fillHeight: true

            txt: qsTr("Nuovo giocatore")
            src: "qrc:/icons/new-user"
            buttonColor: "green"
        }
    }
}
