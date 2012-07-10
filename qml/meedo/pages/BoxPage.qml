
import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.1
import "../js/core.js" as Core
import "../delegates"

Page {

    id : root

    property int boxId: 0 // (flickable1.contentX<item3.width/3) ? 0 : (flickable1.contentX<item3.width*2/3) ? 1 : 2
    property string title

    //property int count
    //property int count1
    //property int count2


    PathView {
        id: pathView
        anchors.top: titleheader1.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        clip: true
        flickDeceleration: 200

        model: modelX
        path: Path {
            startX: -root.width/2; startY: pathView.height/2
            PathLine{ x: 2.5*root.width; y: pathView.height/2}
        }
    }

    VisualItemModel{
        id: modelX

        Item {
            id: item4
            height: pathView.height
            width: root.width
            opacity: 1


            ListView {
                id: itemView2
                anchors.fill: parent
                cacheBuffer : height*3
                delegate: TodoItemDelegate {

                    id: todoItemDelegate2
                    itemTitle: model.title
                    date: model.modified
                    checked: model.done
                    onArrowClicked: {
                        try{
                        var res = JSON.parse(model.note)

                        //console.log(data)
                        if(res.list.length>0){
                            modelZ.clear()
                        for(var i = 0; i < res.list.length; i++){
                            modelZ.append(res.list[i])
                        }
                        todoItemDelegate2.listCreate()
                        }
                        }catch(e){}
                    }

                    onListCheckChanged: {
                        var item = {} //Core.readTodoItem(model.id)
                        item.id = model.id
                        item.box = boxx()

                        var res = JSON.parse(model.note)
                        res.list = []
                        for(var i = 0; i<modelZ.count; i++){
                            res.list[i] = modelZ.get(i)
                        }

                        item.note = (JSON.stringify(res))
                        item.arg = "update"
                        item.title = model.title
                        item.modified = model.modified
                        mainWorker.sendMessage(item)
                        itemView2.currentIndex = index
                        itemModel2.setProperty(index, "note", item.note)
                    }

                    onClicked: {
                        root.pageStack.push(window.todoPage, {todoId: model.id, tittle: model.title, donn: checked, notte: model.note, index: index})
                    }
                    onPressAndHold: {
                        showContextMenu(index, checked, model.note, model.id, model.modified)
                    }
                    onCheckBoxClicked: {
                        if(checked != model.done) {
                            itemModel2.setProperty(index, 'done', checked)
                            var item = {box: "", done: "", title: "", note: "", modified: "", id: "", box2: ""  }
                            item.box = model.box
                            item.done = checked
                            item.id = model.id
                            item.title = model.title
                            item.note = model.note
                            item.modified = model.modified
                            worker1.sendMessage(item)
                            //Core.updateTodo(model)
                        }
                    }
                }
                model: itemModel2
            }

            ListModel {
                id: itemModel2

//                ListElement{
//                    title : "Heello"
//                    modified : "OKKKKKK"
//                }
            }
            scale: (1-0.5*Math.abs(x/root.width))
            //{(flickable1.contentX>=item3.width/2 && flickable1.contentX <= item3.width*5/6)?1.0:0.7 }
        }

        Item {
            id: item2
            height: pathView.height
            width: root.width
            scale: (1-0.5*Math.abs(x/root.width))


            ListView {
                id:  itemView
                anchors.fill: parent
                cacheBuffer : height*3
                model: itemModel
                delegate: TodoItemDelegate {

                    id: todoItemDelegate
                    itemTitle: model.title
                    date: model.modified
                    checked: model.done
                    onArrowClicked: {
                        try{
                        var res = JSON.parse(model.note)

                        //console.log(data)
                        if(res.list.length>0){
                            modelZ.clear()
                        for(var i = 0; i < res.list.length; i++){
                            modelZ.append(res.list[i])
                        }
                        todoItemDelegate.listCreate()
                        }
                        }catch(e){}
                    }

                    onListCheckChanged: {
                        var item = {} //Core.readTodoItem(model.id)
                        item.id = model.id
                        item.box = boxx()

                        var res = JSON.parse(model.note)
                        res.list = []
                        for(var i = 0; i<modelZ.count; i++){
                            res.list[i] = modelZ.get(i)
                        }

                        item.note = (JSON.stringify(res))
                        item.arg = "update"
                        item.title = model.title
                        item.modified = model.modified
                        mainWorker.sendMessage(item)
                        itemView.currentIndex = index
                        itemModel.setProperty(index, "note", item.note)
                    }

                    onClicked: {
                        root.pageStack.push(window.todoPage, {todoId: model.id, tittle: model.title, donn: checked, notte: model.note, index: index})
                    }
                    onPressAndHold: {
                        showContextMenu(index, checked, model.note, model.id, model.modified)
                    }
                    onCheckBoxClicked: {
                        if(checked != model.done) {
                            itemModel.setProperty(index, 'done', checked)
                            var item = {box: "", done: "", title: "", note: "", modified: "", id: "", box2: ""  }
                            item.box = model.box
                            item.done = checked
                            item.id = model.id
                            item.title = model.title
                            item.note = model.note
                            item.modified = model.modified
                            worker1.sendMessage(item)
                            //Core.updateTodo(model)
                        }
                    }
                }
            }

            ListModel {
                id: itemModel
            }



        }

        Item {
            id: item1
            height: pathView.height
            width: root.width
            opacity: 1
            scale: (1-0.5*Math.abs(x/root.width))


            ListModel {
                id: itemModel1
            }

            ListView {
                id:  itemView1
                anchors.fill: parent
                cacheBuffer : height*3

                model: itemModel1
                delegate: TodoItemDelegate {

                    id: todoItemDelegate1
                    itemTitle: model.title
                    date: model.modified
                    checked: model.done
                    onArrowClicked: {
                        try{
                        var res = JSON.parse(model.note)

                        //console.log(data)
                        if(res.list.length>0){
                            modelZ.clear()
                        for(var i = 0; i < res.list.length; i++){
                            modelZ.append(res.list[i])
                        }
                        todoItemDelegate1.listCreate()
                        }
                        }catch(e){}
                    }

                    onListCheckChanged: {
                        var item = {} //Core.readTodoItem(model.id)
                        item.id = model.id
                        item.box = boxx()

                        var res = JSON.parse(model.note)
                        res.list = []
                        for(var i = 0; i<modelZ.count; i++){
                            res.list[i] = modelZ.get(i)
                        }

                        item.note = (JSON.stringify(res))
                        item.arg = "update"
                        item.title = model.title
                        item.modified = model.modified
                        mainWorker.sendMessage(item)
                        itemView1.currentIndex = index
                        itemModel1.setProperty(index, "note", item.note)
                    }

                    onClicked: {
                        root.pageStack.push(window.todoPage, {todoId: model.id, tittle: model.title, donn: checked, notte: model.note, index: index})
                    }
                    onPressAndHold: {
                        showContextMenu(index, checked, model.note, model.id, model.modified)
                    }
                    onCheckBoxClicked: {
                        if(checked != model.done) {
                            itemModel1.setProperty(index, 'done', checked)
                            var item = {box: "", done: "", title: "", note: "", modified: "", id: "", box2: ""  }
                            item.box = model.box
                            item.done = checked
                            item.id = model.id
                            item.title = model.title
                            item.note = model.note
                            item.modified = model.modified
                            worker1.sendMessage(item)
                            //Core.updateTodo(model)
                        }
                    }
                }
            }

        }

    }


    WorkerScript{
        id: worker1
        source: "script2.js"
    }

    WorkerScript{
        id: worker2
        source: "script3.js"
    }


    TodoCreateDialog {
        id: todoCreateDialog
        boxId : boxx()

//        onRejected: {

//            var dtum = parseInt(Core.readId()) + 1
//            print("todoId=" + "" + dtum)
//        }
        onAccepted: {
            if(todoTitle !== "") {
                var item = { box: "", done: false, title: "", note: "", modified: "", box2: "", id: "99"  } //Core.defaultItem()
                item.box = boxId
                var strr = "" + Qt.formatDateTime(new Date(), ("d MMM yyyy h:m:s AP"))
                item.modified = strr
                item.title = todoTitle
                item.note = todoNote
                item.arg = "create"
                var dtum = parseInt(Core.readId()) + 1
                mainWorker.sendMessage(item)


                item.id = dtum

                if(boxId===0){
                    itemView.model.insert(0,item)
                    //itemView.model.setProperty(0, "id", Core.readId()+1)
                }
                else if(boxId===1)
                    itemView1.model.insert(0,item)
                else if(boxId===2)
                    itemView2.model.insert(0,item)

                //Core.createTodo(item)
                //updateUi()
                //updateUi2()
                //updateUix2()
                //updateUix3()
            }
        }
    }

    Menu {
             id: mainMenu
             content: MenuLayout {
                 MenuItem {
                     text: "Deleted completed tasks"
                     onClicked :{
                         confirmDialog.open()

                     }
                 }
//                 MenuItem {
////                     Image{
////                         anchors.verticalCenter: parent.verticalCenter
////                         anchors.right: parent.right
////                         source: "images/inbox.svg"
////                     }

//                     text: "Archieve"
//                     onClicked: root.pageStack.push(Qt.resolvedUrl("ArchivePage.qml"))
//                 }
                 MenuItem {
                     text: "Settings"
                     onClicked: root.pageStack.push(Qt.resolvedUrl("ToolPage.qml"))
                 }

                 MenuItem {
                     text: "About"
                     onClicked: root.pageStack.push(Qt.resolvedUrl("About.qml"))
                 }


             }
         }

    tools: ToolBarLayout {
        ToolIcon {
            iconId: "toolbar-add"
            onClicked: todoCreateDialog.open()}

        ToolIcon { id: deleteTool; iconId: "toolbar-view-menu";
            onClicked: mainMenu.open() //{deleteItem(); root.pageStack.pop()}
        }
    }

    ConfirmDialog {
        id: confirmDialog
        message: "All completed items will be deleted. You can not undo the action.\nProceed?"

        onAccepted: {
            Core.updateArchive(boxx())
            listUpdate()
        }
    }



    onStatusChanged: {
        if(status == PageStatus.Activating) {
        }
    }

    function listUpdate(){
        //mainWorker.source = "script4.js"
        var item = {arg: "read", model : itemModel, box : 0}
        var item1 = {arg: "read", model : itemModel1, box : 1}
        var item2 = {arg: "read", model : itemModel2, box : 2}
        mainWorker.sendMessage(item)
        mainWorker.sendMessage(item1)
        mainWorker.sendMessage(item2)
    }

    function propertyUpdate(index, item){

        //var index

        if(boxx()==0){
            //index = itemView.currentIndex
            itemModel.remove(index)
            itemModel.insert(index, item)
        }
        if(boxx()==1){
            //index = itemView1.currentIndex
            itemModel1.remove(index)
            itemModel1.insert(index, item)
        }
        if(boxx()==2){
            //index = itemView2.currentIndex
            itemModel2.remove(index)
            itemModel2.insert(index, item)
        }
    }


    function boxx(){
        var bo = pathView.currentIndex
        return bo
    }

    function showContextMenu(index1, done1, text1, id1, mod1)
    {
        //var currIndex = listView.currentIndex;
        //var listModelItem = listModel.get(currIndex);

        if (done1) {
            contextMenu.title = "Done";
        }
        else {
            contextMenu.title = "Not done";
        }
        contextMenu.text1 = text1
        contextMenu.id1 = id1
        contextMenu.mod1 = mod1
        contextMenu.index1 = index1
        contextMenu.open();
    }

    BoxSelectionDialog {
        id: moveToDialog

        onAccepted:{
            var box = model.get(selectedIndex).boxId
            //print(box, selectedIndex)
            var item = Core.readTodoItem(contextMenu.id1)
            item.box = box
            Core.updateTodo(item)
            listUpdate()

        }
    }

    ContextMenu {
        id: contextMenu
        property string title
        property string text1
        property string id1
        property string mod1
        property int index1


        MenuLayout {
            /*MenuItem {
                text: contextMenu.title
                //onClicked: //{
                     //if(contextMenu.done != model.done) {
                       // itemModel.setProperty(index, 'done', checked)
                        //Core.updateTodo(model)
                    //}
                    //var currIndex = listView.currentIndex;
                    //var listModelItem = listModel.get(currIndex);

                //}
            }*/

//            Text {
//                color: "#ffffff"
//                text: "Last edited: " + contextMenu.mod1 + "\n" + "Status: " + contextMenu.title
//                font.pointSize: 5
//                horizontalAlignment: Text.AlignHCenter
//                verticalAlignment: Text.AlignVCenter
//                anchors.leftMargin: 10
//                anchors.left: parent.left
//                anchors.right: parent.right
//                anchors.rightMargin: 10
//                height: mitem.height
//                elide: Text.ElideRight
//                maximumLineCount: 3
//                clip: true

//            }

            MenuItem {
                id: mitem
                text: "Edit"
                onClicked: {
                    root.pageStack.push(window.todoPage, {todoId: contextMenu.id1})
                }


            }

            MenuItem {
                text: "Change priority"
                onClicked: {
                    moveToDialog.open()
                }


            }


            MenuItem {
                text: "Delete"
                onClicked: {

                    //Core.deleteTodo(contextMenu.id1)
                    worker2.sendMessage(contextMenu.id1)
                    var boxModel = (boxx()==0) ? itemView.model : (boxx()==1) ? itemView1.model : itemView2.model
                    boxModel.remove(contextMenu.index1)
                }
            }
        }
    }

 PageIndicator{
     totalPages: 3
     currentPage : pathView.currentIndex == 0 ? 1 : pathView.currentIndex == 1 ? 2 : 3
     anchors.bottom: parent.bottom
     anchors.bottomMargin: 15
     anchors.horizontalCenter: parent.horizontalCenter
 }

 TitleHeader {
     text: pathView.currentIndex == 0 ? "Important" : pathView.currentIndex == 1 ? "Normal" : "Low"
     id: titleheader1
     anchors.right: parent.right
     anchors.left: parent.left
     anchors.top: parent.top
 }

 Label{
     text: "Add your tasks to begin.\nSwipe to access other lists."
     verticalAlignment: Text.AlignVCenter
     horizontalAlignment: Text.AlignHCenter
     opacity: 0.5
     anchors.verticalCenter: parent.verticalCenter
     anchors.horizontalCenter: parent.horizontalCenter
     visible: itemView.count + itemView1.count + itemView2.count < 1
 }
}
