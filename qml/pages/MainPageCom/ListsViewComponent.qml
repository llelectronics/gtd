import QtQuick 2.0
import Sailfish.Silica 1.0


Item {
    id: lsViewComponent

    property string title
    property var model
    property string icon
    property string filter
    property alias listView: listView
    property string type

    height: mainPage.height; width: mainPage.width

    SilicaListView {
        id: listView
        model: parent.model
        anchors.fill: parent
        header: PageHeader {
            title: lsViewComponent.title
            Image {
                id: headerIcon
                anchors.right: _titleItem.left
                anchors.rightMargin: Theme.paddingMedium
                width: Theme.iconSizeSmall
                height: width
                source: lsViewComponent.icon
            }
        }
        delegate:
            // TODO Add proper list item
            TodoItem {
            id: todoItem
            title: ttitle
            catColor1: tcatColor1
            catColor2: tcatColor2
            catColor3: tcatColor3
            moveRightIcon: tmoveRightIcon
            width: parent.width - Theme.paddingMedium * 2
            anchors.horizontalCenter: parent.horizontalCenter

            //            BackgroundItem {
            //            id: delegate

            //            Label {
            //                x: Theme.paddingLarge
            //                text: qsTr("Item") + " " + index
            //                anchors.verticalCenter: parent.verticalCenter
            //                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            //            }
            onItemClicked: console.debug("Clicked " + ttitle)
            onMoveRightButtonClicked: console.debug("Move todo with title:" + ttitle + " to the right")
        }
        VerticalScrollDecorator {}
    }
}
