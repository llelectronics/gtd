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
        spacing: Theme.paddingSmall
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
            ident: tid
            catColor1: tcatColor1
            catColor2: tcatColor2
            catColor3: tcatColor3
            moveRightIcon: tmoveRightIcon
            width: parent.width - Theme.paddingMedium * 2
            anchors.horizontalCenter: parent.horizontalCenter
            height: Theme.itemSizeLarge

            //            BackgroundItem {
            //            id: delegate

            //            Label {
            //                x: Theme.paddingLarge
            //                text: qsTr("Item") + " " + index
            //                anchors.verticalCenter: parent.verticalCenter
            //                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            //            }
            onItemClicked: console.debug("Clicked " + ttitle)
            onMoveRightButtonClicked: {
                console.debug("Move todo with title:" + ttitle + " and tid " + tid + " to the right. Current: " + lsViewComponent.model)
                if (lsViewComponent.model === todoListModel) {
                    doingListModel.append({"ttitle": title, "tcatColor1":tcatColor1, "tcatColor2":tcatColor2, "tcatColor3":tcatColor3,"tmoveRightIcon":tmoveRightIcon, "tid":ident});
                    todoListModel.rm(tid);
                }
                else if (lsViewComponent.model === doingListModel) {
                    doneListModel.append({"ttitle": title, "tcatColor1":tcatColor1, "tcatColor2":tcatColor2, "tcatColor3":tcatColor3,"tmoveRightIcon":"image://theme/icon-m-acknowledge", "tid":ident});
                    doingListModel.rm(tid);
                }
            }
        }
        VerticalScrollDecorator {}
    }
}
