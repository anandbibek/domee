

import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    id: root
    //opacity: 0.75
//    anchors.leftMargin: 0
//    anchors.rightMargin:0
    anchors { left: parent.left; right: parent.right; top: parent.top }
    height: 70
    color: "#47ad2e"

    //#54b87b

    property alias text: itemText.text
    width: 100
    //property alias text2: itemText2.text


    Label {
        id: itemText
        opacity: 1
        color: "white"
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.left: parent.left
        font.pixelSize: 30
        clip: true
        maximumLineCount: 1
        elide: Text.ElideRight
        anchors.verticalCenter: parent.verticalCenter
    }
//    ListItemText {
//        id: itemText2
//        opacity: 1
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.right: parent.left
//        anchors.rightMargin: 10
//        role: "SelectionSubTitle"
//    }
    Rectangle {
        id: rectangle6
        height: 1
        color: "white"
        anchors.top: parent.bottom
        anchors.right: parent.right
        opacity: 1//0.250
//        gradient: Gradient {
//            GradientStop {
//                position: 0
//                color: "#000000"
//            }

//            GradientStop {
//                position: 1
//                color: "#00000000"
//            }
//        }
        anchors.left: parent.left
    }
}

