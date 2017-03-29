import QtQuick 2.0
import Sailfish.Silica 1.0


ListsViewComponent {
    title: qsTr("Done")
    model: doneListModel

    PullDownMenu {
        id: pulley
        parent: parent.listView
        MenuItem {
            text: qsTr("Clear All")
            onClicked: console.debug("Clear all entries")
        }
    }

}
