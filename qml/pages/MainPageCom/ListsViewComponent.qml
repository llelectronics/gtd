import QtQuick 2.0
import Sailfish.Silica 1.0


Item {
    id: lsViewComponent

    property string title
    property var model
    property string icon
    property string filter
    property alias listView: listView

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
            BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: qsTr("Item") + " " + index
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator {}
    }
}
