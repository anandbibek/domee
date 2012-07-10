

import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.1
import "../js/core.js" as Core
import "../delegates"
import "../pages"


Page {
    id: root
    state: "details"

    property int todoId
    property bool donn
    property string tittle
    property string notte
    property string comment
    property int arrayno: 0
    property int date1 : 0
    property int month1 : 0
    property int year1 : 0
    property int index


    TitleHeader {
        id: header
        text: tittle
    }

    //    CheckBox {
    //        id: doneField
    //        anchors.left: parent.left
    //        anchors.leftMargin: 10
    //        anchors.verticalCenter: titleField.verticalCenter
    //        onClicked: {
    //            update()
    ////            var item
    ////            item = Core.readTodoItem(todoId)
    ////            item.done = doneField.checked
    ////            Core.updateTodo(item)
    //        }
    //    }

    //    TextField {
    //        id: titleField
    //        anchors.topMargin: 10
    //        clip: true
    //        readOnly: true
    //        anchors {
    //            top: header.bottom //doneField.top;
    //            left: doneField.right; right: root.right
    //            margins: 10
    //        }
    //    }


    TextField {
        id: noteField
        x: 60
        y: 40
        anchors.right: button1.left
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.leftMargin: 10
        clip: true
        anchors {
            top: header.bottom;
            left: parent.left
            margins: 10
        }

        Keys.onPressed: {
            event.accepted = true
            switch (event.key) {
            case Qt.Key_Return:
            case Qt.Key_Select:
            case Qt.Key_Enter: {
                if(noteField.text != ""){
                    listModel.insert(0,{checkStatus : false, textString : noteField.text})
                    noteField.text = ""
                    update()
                }
            }
            break

            }
        }

        MouseArea {
            id: mouse_area1
            x: 205
            width: noteField.text==""? 0 : 40
            clip: true
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: noteField.text = ""

            Image {
                id: image1
                x: -206
                y: 126
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: mouse_area1.pressed? "images/addP.svg" : "images/addN.svg"
            }
        }
    }

    tools: ToolBarLayout {
        ToolIcon {
            iconId: "toolbar-back";
            onClicked:{
                if(comment != commentField.text)
                    update()
                root.pageStack.pop()
            }
        }

        //ToolButton { id: editTool; iconSource: "toolbar-previous"; onClicked: root.pageStack.replace(window.todoPage2, {todoId: checkvalidity2(todoId) })}
        //ToolButton { id: doneTool; iconSource: "toolbar-next"; onClicked: {update(); root.state="details"}}
        ToolIcon { id: moveTool; iconId: "toolbar-new-chat";
            onClicked: {
                item1.visible = true
                itemView.width == 0 ? itemView.width = parent.width : itemView.width = 0
            }
        }
        ToolIcon { iconId: "toolbar-settings"; onClicked: moveToDialog.open()}
        //ToolButton { id: moveTool; iconSource: "toolbar-next"; onClicked: root.pageStack.replace(window.todoPage2, {todoId: checkvalidity(todoId)})}




        ToolIcon { id: deleteTool; iconId: "toolbar-view-menu";
            onClicked: mainMenu.open() //{deleteItem(); root.pageStack.pop()}
        }

    }

    onStatusChanged: {
        //var item
        if(status == PageStatus.Activating) {
            //item = Core.readTodoItem(todoId)
            listModel.clear()
            commentField.text = ""
            jsonParse(notte)
            //listModel = JSON.parse(notte)

        }
    }


    function jsonParse(data){
        try{
            var res = JSON.parse(data)
            //console.log(data)
            for(var i = 0; i < res.list.length; i++){
                listModel.append(res.list[i])
            }
        }
        catch(e){
            commentField.text = data
            comment = ""
        }
        try{
            commentField.text = res.comment
            comment = res.comment
        } catch(e){

        }
    }

    function jsonStringify(){
        var data = {}
        data.list = []
        for(var i = 0; i<listModel.count; i++){
            data.list[i] = listModel.get(i)
            //list[i] = item
        }
        data.comment = commentField.text
        //console.log(JSON.stringify(data))
        return (JSON.stringify(data))
    }

    function deleteItem()
    {
        Core.deleteTodo(todoId)
    }

    function update()
    {
        //jsonStringify()
        var item = {} //Core.readTodoItem(todoId)
        item.box = boxPage.boxx()
        item.id = todoId
        item.done = donn
        item.title = tittle
        item.note = jsonStringify()
        item.arg = "update"
        item.modified = Qt.formatDateTime(new Date(), ("d MMM yyyy h:m:s AP"))
        //mainWorker.source = "script4.js"
        mainWorker.sendMessage(item)
        boxPage.propertyUpdate(index,item)
        //Core.updateTodo(item)

    }


    Button {
        id: button1
        y: 40
        width: 100
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: noteField.verticalCenter
        smooth: true
        text: "Add"
        anchors.right: parent.right
        anchors.rightMargin: 10
        //iconSource: "images/addI.svg"
        onClicked: {
            if(noteField.text != ""){
                listModel.insert(0,{checkStatus : false, textString : noteField.text})
                noteField.text = ""
                update()
            }
        }
    }

    BoxSelectionDialog {
        id: moveToDialog


        onAccepted:{
            var box = model.get(selectedIndex).boxId
            print(box, selectedIndex)
            var item = Core.readTodoItem(todoId)
            item.box = box
            Core.updateTodo(item)
            boxPage.listUpdate()
            root.pageStack.pop()

        }
    }
    Menu {
        id: mainMenu
        content: MenuLayout {
            //                 MenuItem {
            //                     text: "Edit"
            //                     onClicked: root.state = "edit"
            //                 }
            MenuItem {
                text: "Change priority"
                onClicked: moveToDialog.open()
            }
            MenuItem {
                text: "Delete entry"
                onClicked: deletedialog.open()
            }

        }
    }


    ConfirmDialog{
        id :deletedialog
        message: "Delete this entry?"
        onAccepted: {deleteItem(); root.pageStack.pop()}
    }






    Item {
        id: item1
        clip: true
        visible: false
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: itemView.right
        anchors.top: noteField.bottom
        anchors.topMargin: 10

        //        Button {
        //            id: button2
        //            text: "Add selected text to list"
        //            anchors.top: parent.top
        //            anchors.right: parent.right
        //            anchors.rightMargin: 10
        //            anchors.left: parent.left
        //            anchors.leftMargin: 10
        //            onClicked: {
        //                var index1 = commentField.selectionStart
        //                var index2 = commentField.selectionEnd
        //                if(index1 != index2){
        //                    listModel.insert(0,{checkStatus : false, textString : commentField.text.substring(index1,index2)})
        //                    commentField.cursorPosition = index1
        //                    commentField.text = commentField.text.slice(index1,index2)
        //                    update()
        //                }
        //            }
        //        }

        TextArea {
            id: commentField
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            anchors.leftMargin: 10
        }

    }
    ListView {
        id: itemView
        width: parent.width
        height: 548
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: noteField.bottom
        anchors.topMargin: 10
        clip: true
        cacheBuffer : height*3

        delegate: SubListDelegate{
            status: model.checkStatus
            title: model.textString
            onCheckChanged: {

                listModel.setProperty(index, 'checkStatus', status)
                update()
            }
            onDel: {

                listModel.remove(index)
                update()
            }
            onEdit: {
                noteField.text = model.textString
                listModel.remove(index)
                update()
            }
        }

        model: listModel

        Behavior on width {
            NumberAnimation{
                duration: 200
            }
        }
    }


    ListModel {
        id : listModel
    }

















}

