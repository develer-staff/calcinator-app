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
    title: qsTr("Calcinator")

    header: Header {
        backButtonVisible: mainStackView.depth > 1
        onBackButtonPressed: mainStackView.pop()
        title: mainStackView.currentItem.title
        rightButton: mainStackView.currentItem.rightButton
    }

    StackView {
        id: mainStackView

        anchors.fill: parent
        initialItem: mainPage
    }

    Component {
        id: newMatchPage
        NewMatch {
            property string title: qsTr("New match")

            onNewMatchReady: console.log("Ready to start")
        }
    }

    Component {
        id: mainPage
        MainPage {
            property string title: qsTr("Main Page")

            onNewMatch: mainStackView.push(newMatchPage)
        }
    }
}
