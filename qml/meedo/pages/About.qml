import QtQuick 1.1
import com.nokia.meego 1.0
import "../delegates"

Page {
    id: root

    TitleHeader{
        id: titleheader1
        text: "About"

    }

    Flickable {
        id: flickable1
        anchors.top: titleheader1.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        contentHeight: textContainer.height
        clip: true

        Item {
            id: textContainer
            height: text.height + anchors.margins * 2

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 20
            }

            Label {
                id: text
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: 26
                text: qsTr("<p><h1>DoMee 1.1 </h1> A personal To Do manager with the general functions. " +
                           "Specialises on sleek and fast approach, with an elegant UI. " +
                           "<p>User can input multiple entries categorised in three priority levels, with the option to add notes and sub list.\n<h4>Swipe the main screen to access the other lists</h4>  " +
                           "<br><br><h5>Developed by @Anand_Bibek<br>theweekendcoder.blogspot.com"
                           );

            }
        }
    }







    tools: ToolBarLayout {
        ToolIcon {iconId: "toolbar-back"; onClicked: root.pageStack.pop() }

        ToolIcon {iconId: "toolbar-home"; onClicked: root.pageStack.pop() }
        ToolIcon {iconId: "toolbar-settings"; onClicked: root.pageStack.push(Qt.resolvedUrl("ToolPage.qml")) }


        ToolIcon {iconId: "toolbar-share"; onClicked: Qt.openUrlExternally("http://twitter.com/Anand_Bibek/") }





    }

}
