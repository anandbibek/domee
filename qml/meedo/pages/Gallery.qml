// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.gallery 1.1

import "../delegates"

Page {
    id : gPage



         GridView {
             id : grid
             property int size : parent.width/4
             anchors.top: titleheader1.bottom
             anchors.right: parent.right
             anchors.bottom: parent.bottom
             anchors.left: parent.left
             cellWidth: 90
             cellHeight: 90

             model: DocumentGalleryModel {
                 rootType: DocumentGallery.Image
                 scope: DocumentGallery.Image
                 properties: [ "url" ]
                 limit: 200
                 //autoUpdate: true
//                 filter: GalleryContainsFilter{
//                     property: "filename"
//                     value: "jpg"
//                 }

             }

             delegate: Image {
                 id: img
                 source: url
                 asynchronous: true
                 fillMode: Image.PreserveAspectFit
                 clip: true
                 width: grid.size
                 height: grid.size
                 sourceSize.width: grid.size

                 MouseArea{
                     anchors.fill: parent
                     onClicked: {
                         window.imagex(img.source)
                         imagex.source = img.source
                         pageStack.pop()
                         console.log(model.url)
                     }
                 }
                 Rectangle{
                     color: "#00000000"
                     z : -1
                     border.color: "black"
                     anchors.fill: parent
                 }
             }
         }

         tools: ToolBarLayout{
             ToolButton{
                 iconSource: "toolbar-back"
                 onClicked: pageStack.pop()
             }
             ToolButton {
                 iconSource: "toolbar-menu"
                 onClicked: menu.open()
             }
         }

         Menu {
                  id: menu
                  content: MenuLayout {
                      MenuItem {
                          text: "Default image (Texture)"
                          onClicked :{
                              window.imagex("./images/bg2.jpg")
                              imagex.source = "../images/bg2.jpg"
                              pageStack.pop();
                          }
                      }
                      MenuItem {
                          text: "Default image (Gradient)"
                          onClicked :{
                              window.imagex("./images/bg3.jpg")
                              imagex.source = "../images/bg3.jpg"
                              pageStack.pop();
                          }
                      }
                      MenuItem {
                          text: "Default black"
                          onClicked: {pageStack.pop(); imagex.source = ""; window.imagex("")}
                      }


                  }
         }


         TitleHeader{
             id: titleheader1
             text: "Background"

         }
//         ScrollBar{
//             anchors.top: titleheader1.bottom
//             anchors.right: parent.right
//             flickableItem: grid
//             interactive : true
//             policy: Symbian.ScrollBarWhenNeeded
//         }
}
