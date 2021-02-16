import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import players 1.0

ColumnLayout {
    readonly property Component rightButton: rightButtonComponent

    spacing: 0

    QtObject {
        id: scores

        property int blueScore: 0
        property int redScore: 0
    }

    Repeater {
        id: scoresRepeater

        model: [PlayersModel.Red, PlayersModel.Blue]

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: modelData === PlayersModel.Red ? "red" : "blue"

            Column {
                anchors.centerIn: parent

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "%1".arg(scoreSlider.value)
                }

                Slider {
                    id: scoreSlider

                    anchors.horizontalCenter: parent.horizontalCenter
                    from: 0
                    to: 6
                    stepSize: 1

                    onValueChanged: {
                        if (modelData === PlayersModel.Red)
                            scores.redScore = value
                        else
                            scores.blueScore = value
                    }
                }
            }
        }
    }

    Component {
        id: rightButtonComponent

        Button {
            text: qsTr("Submit")
            background: Item {}

            enabled: {
                if (scores.redScore < 5 && scores.blueScore < 5)
                    return false

                return true
            }
        }
    }
}
