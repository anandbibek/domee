
import QtQuick 1.1
import com.nokia.meego 1.0

SelectionDialog {
    id: root
    titleText: "Priority"
    model: ListModel {
        ListElement { name: "Important"; boxId: 0}
        ListElement { name: "Normal"; boxId: 1}
        ListElement { name: "Low";  boxId: 2}
        //ListElement { name: "Later"; boxId: 3}
    }
    //delegate: itemDelegate
}
