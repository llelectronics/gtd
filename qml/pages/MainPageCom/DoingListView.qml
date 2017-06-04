import QtQuick 2.0
import Sailfish.Silica 1.0


ListsViewComponent {
    title: qsTr("Doing")
    model: doingListModel
    modelId: "doingList"

    PullDownMenu {
        id: pulley
        parent: parent.listView
        MenuItem {
            text: qsTr("Filter")
            onClicked: pageStack.push(Qt.resolvedUrl("Filter.qml"), {model: doingListModel} );
        }
    }

}
