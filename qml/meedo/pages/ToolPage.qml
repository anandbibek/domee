

import QtQuick 1.1
import com.nokia.meego 1.0
import "../js/core.js" as Core
import "../delegates"

Page {
    id: root

    ListModel {
        id: caseModel

        ListElement { title: "Reset Table";           name : "resetTable"  }
//        ListElement { title: "Dark theme"; name : "Change background"  }
//        ListElement { title: "10 Todo Item";          name: "createTodos10" }
//        ListElement { title: "100 Random Todo Item";  name: "createTodos100" }
//        ListElement { title: "1000 Random Todo Item"; name: "createTodos1000" }
    }

    function runTest(testName)
    {
        print("run test " + testName)
        switch(testName){
        case "resetTable" :
            Core.dropTable()
            Core.createTable()
            break;
        case "createTodos10" :
            createTodos(10)
            break;
        case "createTodos100" :
            createTodosRandomBox(100)
            break;
        case "createTodos1000" :
            createTodosRandomBox(1000)
            break;
        case "Change background" :
            theme.inverted = true
            //pageStack.push(Qt.resolvedUrl("Gallery.qml"))
            break;
        }
    }

    function createTodos(count)
    {
        var data = []
        for (var i=0; i< count; i++){
            data[i] = {
                box: 0,
                done: false,
                title: "Todo_"+i+1,
                note: "No Note",
                modified: Qt.formatDateTime(new Date(), ("d MMM yyyy h:m AP"))
            }
        }
        Core.createBatchTodos(data)
    }

    function createTodosRandomBox(count)
    {
        var data = []
        for (var i=0; i< count; i++){
            data[i] = {
                box: Math.floor(Math.random()*5),
                done: i%2?true:false,
                title: "Todo"+i+1,
                note: "No Note",
                modified: Qt.formatDateTime(new Date(), ("d MMM yyyy h:m AP"))
            }
        }
        Core.createBatchTodos(data)
    }

    TitleHeader {
        id: header
        text: "Tool Page"
    }

    ListView {
        id: view
        anchors {
            left: root.left; right:  root.right;
            top: header.bottom; bottom: parent.bottom
        }
        clip: true
        model: caseModel
        delegate: BoxItemDelegate {
            id: itemDelegate
            title: model.title
            onClicked : runTest(model.name)
        }
    }

    tools: ToolBarLayout {
        ToolIcon {iconId: "toolbar-back"; onClicked: root.pageStack.pop() }
    }

}
