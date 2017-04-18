import QtQuick 2.0
import Sailfish.Silica 1.0


ListsViewComponent {
    title: qsTr("Done")
    model: doneListModel
    modelId: "doneList"

    PullDownMenu {
        id: pulley
        parent: parent.listView
        MenuItem {
            text: qsTr("Clear All")
            onClicked: {
                remorse.execute(qsTr("Clear Done entries"), function() { model.clear(); /*TODO: Add db stuff*/ /*mainWindow.db.clear("doneList")*/ } )
            }
        }
    }

}
