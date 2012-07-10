// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: rectangle1
    width: appWidth
    height: appHeight
    color: "black"

    Image {
        id: image1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/2do.png"
    }

    Text {
        id: text1
        color: "#008819"
        text: qsTr("2Do 2.0")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        //font.pixelSize: platformStyle.fontSizeSmall
        horizontalAlignment: Text.AlignRight
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
}
