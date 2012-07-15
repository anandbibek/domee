
//import com.nokia.extras 1.0
import QtQuick 1.1
import com.nokia.meego 1.0
import "js/core.js" as Core
import "pages"

PageStackWindow {
    id: window

//    Item {
//        id: roundedCorners
//        anchors.fill: parent
//        z: 10001

//        Image {
//            anchors.top : parent.top
//            anchors.left: parent.left
//            source: "image://theme/meegotouch-applicationwindow-corner-top-left"
//        }
//        Image {
//            anchors.top: parent.top
//            anchors.right: parent.right
//            source: "image://theme/meegotouch-applicationwindow-corner-top-right"
//        }
//        Image {
//            anchors.bottom : parent.bottom
//            anchors.left: parent.left
//            source: "image://theme/meegotouch-applicationwindow-corner-bottom-left"
//        }
//        Image {
//            anchors.bottom : parent.bottom
//            anchors.right: parent.right
//            source: "image://theme/meegotouch-applicationwindow-corner-bottom-right"
//        }
//    }

//    Image {
//        id:imagex
//        x: (parent.width - width)/2
//        visible: true
//        source: "images/bg3.jpg" //Core.saveSetting("", true, "bgSource")
//        asynchronous: true
//    }

    function imagex(xyz){
        imagex.source = xyz
        var item = {}
        item.name = "bgSource"
        item.value = xyz
        Core.saveSetting(item, false, "")
    }

    BoxPage{id: boxPage}
    property variant todoPage: TodoPage{}
    //property variant todoPage2: TodoPage2{}

//    PageStack {
//        clip: true
//        id: pageStack
//        anchors {
//            top: parent.top; bottom: toolBar.top
//            left: parent.left; right: parent.right
//            margins: 0
//        }

//        Rectangle {
//            id: rectangle5
//            x: 0
//            y: 544
//            z: 1
//            height: 10
//            gradient: Gradient {
//                GradientStop {
//                    position: 0
//                    color: "#00000000"
//                }

//                GradientStop {
//                    position: 1
//                    color: "#000000"
//                }
//            }
//            opacity: 0.750
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//            anchors.rightMargin: 0
//            anchors.right: parent.right
//            anchors.leftMargin: 0
//            anchors.left: parent.left
//        }
//        toolBar: toolBar
//    }
//    ToolBar {
//        opacity: .8
//        z:0
//        id: toolBar1
//        anchors.bottom: window.bottom
//    }
//    ToolBar {
//        //width: 0
//        id: toolBar
//        anchors.bottom: parent.bottom
//        tools: ToolBarLayout {
//            id: toolBarLayout
//        }
//    }

    WorkerScript{
        id: mainWorker
        source: "pages/script4.js"

    }

//    InfoBanner {
//        id: banner
//        x: 0
//        y: -48
//        anchors.top: statusBar.bottom
//        anchors.topMargin: -74
//        anchors.left: parent.left
//        anchors.leftMargin: 0
//        anchors.right: parent.right
//        anchors.rightMargin: 0
//        timeout: 3000
//        interactive: true
//        onClicked: banner.close()
//    }

    Component.onCompleted:
    {
        Core.openDB();
        boxPage.listUpdate()
        pageStack.push(boxPage)
        theme.colorScheme = 15
        //pageStack.push(Qt.resolvedUrl("pages/BoxPage.qml"));
    }
}

