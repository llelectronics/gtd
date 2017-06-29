import QtQuick 2.0
import Sailfish.Silica 1.0
import "../helper/db.js" as DB


Item {
    id: lsViewComponent

    property string title
    property var model
    property string icon
    property string filter
    property alias listView: listView
    property string type
    property string modelId // Used for identifying the model
    property int lid // Used for the DB access

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
            BackgroundItem {
            id: bgdelegate
            width: parent.width
            height: menuOpen ? contextMenu.height + todoItem.height : todoItem.height
            property Item contextMenu
            property bool menuOpen: contextMenu != null && contextMenu.parent === bgdelegate

            function remove() {
                var removal = removalComponent.createObject(bgdelegate)
                removal.execute(todoItem,qsTr("Deleting ") + ttitle, function() { listView.remove(index); DB.removeTodo(tid,lid) })
            }

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

                function showContextMenu() {
                    if (!contextMenu)
                        contextMenu = myMenu.createObject(listView)
                    contextMenu.show(bgdelegate)
                }

                onItemClicked: {
                    console.debug("Clicked " + ttitle)
                    pageStack.push(Qt.resolvedUrl("CreateTodo.qml"), {lid: lid, ttitle: ttitle, tcatColor1: tcatColor1, tcatColor2: tcatColor2, tcatColor3: tcatColor3,
                                       tmoveRightIcon: tmoveRightIcon, tid: tid, tnote: tnote, taudio: taudio, timage: timage, edit: true, model: lsViewComponent.model} );
                }
                onItemPressAndHold: showContextMenu()
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

            Component {
                id: removalComponent
                RemorseItem {
                    id: remorse
                    onCanceled: destroy()
                }
            }

            Component {
                id: myMenu
                ContextMenu {
                    MenuItem {
                        text: qsTr("Delete")
                        onClicked: {
                            bgdelegate.remove();
                        }
                    }
                }
            }
        } // Background Item End
        VerticalScrollDecorator {}
    }
}
