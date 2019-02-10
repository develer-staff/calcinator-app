import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import Components 1.0
import Pages 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    header: Item {
        property alias title: headerTitle.text
        implicitHeight: 30

        Image {
            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
            visible: mainPage.depth > 1

            source: "icons/arrow.png"

            sourceSize {
                width: height
                height: parent.height - 8
            }

            MouseArea {
                anchors.fill: parent
                onClicked: mainPage.pop()
            }
        }

        Text {
            id: headerTitle
            anchors.centerIn: parent
        }
    }

    StackView {
        id: mainPage

        anchors.fill: parent
        initialItem: first

        onCurrentItemChanged: {
            header.title = currentItem.title
        }
    }

    Component {
        id: newMatchPage
        NewMatch {
            property string title: "New match"
        }
    }

    Component {
        id: first

        Page {
            title: "Home page"

            contentItem: ColumnLayout {
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
}
