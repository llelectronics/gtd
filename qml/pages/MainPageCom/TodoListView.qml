import QtQuick 2.0
import Sailfish.Silica 1.0


ListsViewComponent {
    title: qsTr("Todo")
    model: todoListModel
    modelId: "todoList"
    lid: 0

    PullDownMenu {
        id: pulley
        parent: parent.listView
        MenuItem {
            text: qsTr("Add Todo")
            onClicked: pageStack.push(Qt.resolvedUrl("CreateTodo.qml"), {lid: lid, model: model} );
        }
        MenuItem {
            text: qsTr("New List")
            onClicked: pageStack.push(Qt.resolvedUrl("AddList.qml"));
        }
        MenuItem {
            text: qsTr("Filter")
            onClicked: pageStack.push(Qt.resolvedUrl("Filter.qml"), {model: todoListModel} );
        }
    }

}
