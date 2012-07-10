
import QtQuick 1.1
import com.nokia.meego 1.0

MouseArea {
    id: listItem
    //subItemIndicator: true
    clip: true
    height: customcolumn.height + 50
    width: parent.width

    property alias itemTitle: todoTitle.text
    property alias checked: checkBox.checked
    property alias date: customdate.text
    property variant modelZ : listModelxx
    //property alias color: rectangle1.color

    signal checkBoxClicked()
    signal arrowClicked()
    signal listCheckChanged()

    function listCreate(){
        if(loader.sourceComponent==listComp){
            listItem.height = listItem.height -loader.height
            loader.sourceComponent = null
        }
        else
            loader.sourceComponent = listComp
    }

    onPressed : listItem.ListView.view.currentIndex = index


    Behavior on height {
        NumberAnimation {
            duration: 200
        }
    }

    ListView.onRemove: SequentialAnimation {
        PropertyAction { target: listItem; property: "ListView.delayRemove"; value: true }
        ParallelAnimation {
            SequentialAnimation {
                PauseAnimation { duration: 50 }
                NumberAnimation {
                    target: listItem
                    property: "height"
                    to: 0
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
            NumberAnimation {
                target: listItem
                property: "opacity"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.Linear
            }
        }
        PropertyAction { target: listItem; property: "ListView.delayRemove"; value: false }
    }

    ListView.onAdd: SequentialAnimation {
        PropertyAction { target: listItem; property: "height"; value: 0 }
        ParallelAnimation {
            NumberAnimation {
                target: listItem
                property: "height"
                to: listItem.height
                duration: 250
                easing.type: Easing.OutQuad
            }
            NumberAnimation {
                target: listItem
                property: "opacity"
                from: 0
                to: 1
                duration: 250
                easing.type: Easing.Linear
            }
        }
    }




    Rectangle {
        id: rectangle1
        width: parent.width + 5
        height: parent.height
        color: listItem.pressed? "lightGreen" :"#00000000"
        border.color: "#000000"
        opacity: 0.250
        anchors.verticalCenterOffset: -2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter


    }

    Rectangle {
        height: 1
        color: "white"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    Item{
        id: row;
        anchors{
            fill: parent
            margins: 20
        }

        CheckBox {
            id: checkBox;
            anchors.topMargin: 5
            anchors.top: customcolumn.top
            anchors.left: parent.left
            onClicked: listItem.checkBoxClicked()
        }

        Column{
            id:customcolumn
            anchors.right: toolbutton1.left
            anchors.leftMargin: 10
            anchors.left: checkBox.right
            spacing: 10

            Label {
                id : todoTitle
                elide: Text.ElideLeft
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                maximumLineCount: 1
                clip: true
                font.pixelSize: 28
                //anchors.verticalCenter: parent.verticalCenter

            }


            Label {
                id : customdate
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                //height: listItem.height/3
                maximumLineCount: 1
                clip : true
                font.pixelSize: 18
                opacity: 0.5
                //elide: Text.ElideLeft
                //clip: true
                //anchors.verticalCenter: parent.verticalCenter
            }
        }

        Button {
            id: toolbutton1
            anchors.right: parent.right
            anchors.verticalCenter: checkBox.verticalCenter
            width: 60
            height: 60
            smooth : true
            iconSource:"../images/playI.svg"
            //            Image{
            //                scale: 0.7
            //                smooth: true
            //                anchors.horizontalCenter: parent.horizontalCenter
            //                anchors.verticalCenter: parent.verticalCenter
            //                rotation: 90
            //                source: "../images/playI.svg"
            //            }
            onClicked: {
                toolbutton1.rotation == 0 ? toolbutton1.rotation = 90 : toolbutton1.rotation = 0
                arrowClicked()
            }
            Behavior on rotation {
                SmoothedAnimation {
                    easing.type: Easing.OutBack
                    duration: 200
                }
            }
        }

        Loader{
            id: loader
            anchors.topMargin: 10
            anchors.leftMargin: -10
            anchors.top: customcolumn.bottom
            anchors.right: parent.right
            anchors.left: customcolumn.left
        }
    }

    Component {
        id: listComp

        ListView {
            id: itemView
            height: 60*count
            anchors.fill: parent
            clip: true
            cacheBuffer : height*3
            Component.onCompleted: listItem.height = listItem.height + loader.height

            delegate: SubListDelegate{
                id: subDel
                status: model.checkStatus
                title: model.textString
                editable: false
                onCheckChanged: {
                    listItem.focus = true
                    listModelxx.setProperty(index, 'checkStatus', status)
                    listCheckChanged()
                }
                //                onDel: listModel.remove(index)
                //                onEdit: {
                //                    noteField.text = model.textString
                //                    listModel.remove(index)
                //                }
            }

            model: listModelxx

        }
    }
    ListModel {
        id : listModelxx
    }

}
