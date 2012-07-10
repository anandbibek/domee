

import QtQuick 1.1
import com.nokia.meego 1.0

MouseArea {
    id: listItem
    height: 70
    width: parent.width


    property alias title: boxTitle.text
    property alias count: customtext.text
    property alias id1: boxid.text
    property alias img: imagex.source;

    signal click()

    //Row{
        //id:customrow
        //anchors.fill: listItem.paddingItem
        //spacing: 40
    Image {
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        id: imagex
    }

    /*MouseArea{
        id:arrea
        anchors.top: listItem.top
        anchors.right: listItem.right
        anchors.left: listItem.left
        anchors.bottom: listItem.bottom
        hoverEnabled: true
        onPositionChanged: listItem.click()
        onReleased: listItem.click()
        //preventStealing: true
        onPressAndHold: listItem.click()
        onPressed: listItem.click()
        onEntered: listItem.click()
        onExited: listItem.click()
        onCanceled: listItem.click()
        onClicked: listItem.click()
        onDoubleClicked: listItem.click()

    }*/

    Label{
        id:boxid
        height: 0
        width: 0
        visible: false
    }

    Label {
        id : boxTitle
        anchors.left: imagex.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    Label {
        id : customtext
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }
//}
}
