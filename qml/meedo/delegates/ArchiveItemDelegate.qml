


import QtQuick 1.1
import com.nokia.meego 1.0

MouseArea {
    id: listItem


    property alias title:  itemText.text
    height: itemText.paintedHeight + 20
    width: parent.width

    Row {
        id : row
        anchors.fill: parent
        spacing: 8

        Label {
            id: itemText
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
