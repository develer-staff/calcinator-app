import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import Components 1.0

Page {
    id: root

    signal newMatch()

    contentItem: ColumnLayout {
        spacing: 0
        width: parent.width

        Image {
            id: logo
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/icons/logo"
        }

        MenuItem {
            width: 300
            height: 80

            Layout.alignment: Qt.AlignHCenter

            radius: 30

            txt: qsTr("Nuova partita")
            src: "qrc:/icons/play-button"
            buttonColor: "#03A9F4"

            onSelected: root.newMatch()
        }

        MenuItem {
            width: 300
            height: 80

            Layout.alignment: Qt.AlignHCenter

            radius: 30

            txt: qsTr("Stats")
            src: "qrc:/icons/statistics"
            buttonColor: "#03A9F4"
        }

        MenuItem {
            width: 300
            height: 80

            Layout.alignment: Qt.AlignHCenter

            radius: 30

            txt: qsTr("Nuovo giocatore")
            src: "qrc:/icons/new-user"
            buttonColor: "#03A9F4"
        }
    }
}
