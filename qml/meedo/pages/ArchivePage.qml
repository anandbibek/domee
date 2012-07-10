

import QtQuick 1.1
import com.nokia.meego 1.0
import "../js/core.js" as Core
import "../delegates"
import "../"

Page {
    id: root

    property int boxId:  4
    property string  title :"Archive"

    ListModel {
        id: itemModel
    }

    TitleHeader {
        id: header
        text: root.title
    }

    ListView {
        id: view
        anchors {
            left: root.left; right:  root.right
            top: header.bottom; bottom: parent.bottom
        }
        clip: true
        model: itemModel
        delegate: ArchiveItemDelegate {
            title: model.title
        }
    }

    tools: ToolBarLayout {
        ToolIcon { iconId: "toolbar-back"; onClicked: root.pageStack.pop() }
        ToolIcon { iconId: "toolbar-delete"; onClicked: Core.clearArchive(itemModel) }
        ToolIcon { iconId: "toolbar-refresh"; onClicked: ; }

    }

    onStatusChanged: {
        if(status == PageStatus.Activating) {
            Core.readTodoBox(itemModel, boxId)
        }
    }
}
