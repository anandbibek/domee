// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

MouseArea{
    id: item

    property alias title : texxt.text
    property alias status : box.checked

    property bool editable : true

    signal checkChanged()
    signal del()
    signal edit()

    height : texxt.paintedHeight + 30
    width : parent.width

    Behavior on height {
        SmoothedAnimation{
            duration: 200
        }
    }

    onPressed : {

        item.ListView.view.currentIndex = index
    }


    ListView.onRemove: SequentialAnimation {
        PropertyAction { target: item; property: "ListView.delayRemove"; value: true }
        ParallelAnimation {
            SequentialAnimation {
                PauseAnimation { duration: 50 }
                NumberAnimation {
                    target: item
                    property: "height"
                    to: 0
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
            NumberAnimation {
                target: item
                property: "opacity"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.Linear
            }
        }
        PropertyAction { target: item; property: "ListView.delayRemove"; value: false }
    }

    ListView.onAdd: SequentialAnimation {
        PropertyAction { target: item; property: "height"; value: 0 }
        ParallelAnimation {
            NumberAnimation {
                target: item
                property: "height"
                to: item.height
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: item
                property: "opacity"
                from: 0
                to: 1
                duration: 250
                easing.type: Easing.Linear
            }
        }
    }



    onPressAndHold: {
        if(editable){
        loader.width = parent.width/3
        loader.sourceComponent = rowCom
        //brow.width = parent.width/3
        }
    }
    onClicked: {
        loader.width = 0
        var i1 = texxt.paintedHeight
        texxt.maximumLineCount == 99 ? texxt.maximumLineCount = 1 : texxt.maximumLineCount = 99
        var i2 = texxt.paintedHeight
        item.height = item.height + i2-i1
    }

    Item{
        id: item1
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        anchors{
            fill: parent
            margins: 10
        }

        CheckBox{
            id:box
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            onClicked: checkChanged()
        }

        Label{
            id: texxt
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: 22
            maximumLineCount: 1
            elide: Text.ElideRight
            anchors.leftMargin: 10
            anchors.right: loader.left
            anchors.rightMargin: 0
            anchors.left: box.right
            anchors.verticalCenter: parent.verticalCenter
        }

        Loader {
            id: loader
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 0
        }

        Component{
            id: rowCom

            ButtonRow{
                id: brow
                clip: true
                width: 0
                exclusive: false
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                Button{
                    iconSource: "../images/refreshI.svg"
                    visible: editable
                    onClicked: {
                        edit()
                    }
                }
                Button{
                    iconSource: "../images/deleteI.svg"
                    visible: editable
                    onClicked: del()
                }
            }
        }
    }
}
