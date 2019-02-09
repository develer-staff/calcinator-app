import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import Components 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    StackView {
        id: mainPage
        anchors.fill: parent
        initialItem: first
    }

    Component {
        id: newMatchPage
        NewMatch {
        }
    }

    Component {
        id: first

        ColumnLayout {
            spacing: 0

            MenuItem {
                Layout.fillWidth: true
                Layout.fillHeight: true

                txt: qsTr("Nuova partita")
                src: "icons/play-button"
                buttonColor: "red"

                onSelected: mainPage.push(newMatchPage)
            }

            MenuItem {
                Layout.fillWidth: true
                Layout.fillHeight: true

                txt: qsTr("Stats")
                src: "icons/statistics"
                buttonColor: "yellow"
            }

            MenuItem {
                Layout.fillWidth: true
                Layout.fillHeight: true

                txt: qsTr("Nuovo giocatore")
                src: "icons/new-user"
                buttonColor: "green"
            }
        }
    }
}
