import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

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
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true

                color: "red"
                MouseArea {
                    anchors.fill: parent
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("Nuova partita")
                    }
                    onClicked: {
                        mainPage.push(newMatchPage)
                    }
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true

                color: "blue"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Stats")
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Nuovo giocatore")
                }
            }
        }
    }
}
