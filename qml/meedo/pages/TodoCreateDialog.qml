

import QtQuick 1.1
import com.nokia.meego 1.0

Sheet {
    id: root

    property alias boxId: itemSelection.value
    property int boxId1
    property alias todoTitle: titleField.text
    property alias todoNote: titleField2.text

    content: Column {
        id: column1
        spacing: 10
        anchors.left: parent.left; anchors.right: parent.right

        Label {
//            Rectangle {
//                id: rectangle1
//                x: -54
//                y: 279
//                width: 10
//                height: 10
//                color: itemSelection.value==2?"light blue":itemSelection.value==1?"yellow":"#ff5c5c"
//                radius: 50
//                smooth: true
//                anchors.left: parent.right
//                //anchors.right: column1.right
//                anchors.leftMargin: 50
//                //anchors.horizontalCenter: itemSelection.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter

//                Behavior on color {
//                    ColorAnimation {duration: 200 }
//                }
//            }
            id: titleLabel
            text:  "Title:"
            anchors{
                left: parent.left
                leftMargin: 10
            }
        }

        TextField{
            id: titleField
            placeholderText: "Enter todo title."
            anchors{
                right: parent.right; left: parent.left
                margins: 10
            }
        }
        Label {
            id: titleLabel2
            text:  "Note:"
            anchors{
                left: parent.left
                leftMargin: 10
            }
        }

        TextArea{
            id: titleField2
            placeholderText: "Note (Optional)"
            anchors{
                right: parent.right; left: parent.left
                margins: 10
            }
        }

        Label {
            id : boxLabel;
            text:  "Priority:  " + convert()
            anchors{
                left: parent.left
                margins: 10
            }
        }

       /*SelectionListItem {
            id: itemSelection
            anchors{ right: parent.right; left: parent.left}
            title: selectionDialog.model.get(boxId).name // by default the first item
            onClicked: selectionDialog.open()

            BoxSelectionDialog {
                id: selectionDialog
                titleText: "Select Box"

                onAccepted :{
                    itemSelection.title = model.get(selectedIndex).name
                    boxId = model.get(selectedIndex).boxId
                }
            }
        }*/

        Slider{

            id: itemSelection
            inverted: true
            minimumValue: 0
            maximumValue: 2
            stepSize: 1
            z:1
            valueIndicatorVisible: true
            valueIndicatorText: convert()
            anchors{ right: parent.right; left: parent.left; margins: 50}
            onValueChanged: boxId1 = itemSelection.value
        }




    }




    onStatusChanged: {
        if(status == DialogStatus.Opening) {
            titleField.forceActiveFocus()
            screen.keyboardOpen = true
            todoTitle = ""
            todoNote = ""
            itemSelection.value = boxx()

        }
    }


//    onAccepted: {
//        console.log("hell")
//        root.accept()
//    }

//    onRejected: root.reject()

//    buttons: Row {
//        id: row1
//        spacing: 10
//        //exclusive: false
//        anchors { left: parent.left; right:  parent.right;  margins: 10 }
//        Button { width: parent.width/2-5; text: "Create" ; flat: false; onClicked: root.accept()}
//        Button { width: parent.width/2-5; text: "Cancel"; flat: false; onClicked: root.reject() }
//    }

    function convert(){
        switch (itemSelection.value) {
        case 0 : return "Important";
            break;
        case 1: return "Normal";
            break;
        case 2: return "Low";
            break;
        }
    }


    acceptButtonText : "Create"
    rejectButtonText: "Cancel"
}
