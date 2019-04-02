import QtQuick 2.0

Item {
    id: root

    property alias title: headerTitle.text
    property bool backButtonVisible
    property alias rightButton: rightButton.sourceComponent

    signal backButtonPressed()

    implicitHeight: 30

    Image {
        anchors {
            left: parent.left
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
        visible: backButtonVisible

        source: "qrc:/icons/arrow.png"

        sourceSize {
            width: height
            height: parent.height - 8
        }

        MouseArea {
            anchors.fill: parent
            onClicked: backButtonPressed()
        }
    }

    Text {
        id: headerTitle
        anchors.centerIn: parent
    }

    Loader {
        id: rightButton

        anchors {
            right: parent.right
            rightMargin: 10
            top: parent.top
            bottom: parent.bottom
        }
    }
}
