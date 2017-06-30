import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: rootItem
    property alias catColor1: catColor1.color
    property alias catColor2: catColor2.color
    property alias catColor3: catColor3.color
    property alias title: todoTitle.text
    property alias moveRightIcon: moveRightIcon.source
    property string ident
    property string lident
    signal moveRightButtonClicked
    signal itemClicked
    signal itemPressAndHold

    Rectangle {
        id: todoItem
        width: parent.width
        height: Theme.itemSizeLarge
        color: "transparent"
        border.color: Theme.secondaryColor
        border.width: 1

        Column {
            id: catColorColumn
            width: Theme.itemSizeExtraSmall / 4
            height: parent.height - Theme.paddingSmall * 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingSmall
            Rectangle {
                id: catColor1
                width: parent.width
                height: {
                    if (catColor2.visible && catColor3.visible) parent.height / 3
                    else if (catColor2.visible || catColor3.visible) parent.height / 2
                    else parent.height
                }
                onColorChanged: {
                    if (color == "#000000") visible = false
                }
            }
            Rectangle {
                id: catColor2
                width: parent.width
                height: {
                    if (catColor1.visible && catColor3.visible) parent.height / 3
                    else if (catColor1.visible || catColor3.visible) parent.height / 2
                    else parent.height
                }
                onColorChanged: {
                    if (color == "#000000") visible = false
                }
            }
            Rectangle {
                id: catColor3
                width: parent.width
                height: {
                    if (catColor1.visible && catColor2.visible) parent.height / 3
                    else if (catColor1.visible || catColor2.visible) parent.height / 2
                    else parent.height
                }
                onColorChanged: {
                    //console.debug("Color3 changed to: " + color)
                    if (color == "#000000") visible = false
                }
            }
        }
        TextEdit {
            id: todoTitle
            text: "Todo Title"
            anchors.left: catColorColumn.right
            anchors.leftMargin: Theme.paddingMedium
            anchors.right: moveRightButton.left
            anchors.rightMargin: Theme.paddingMedium
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.primaryColor
            readOnly: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: itemClicked()
            onPressAndHold: itemPressAndHold()
        }

        Rectangle {
            id: moveRightButton
            width: Theme.itemSizeSmall
            height: parent.height
            anchors.right: parent.right
            color: "transparent"
            Image {
                id: moveRightIcon
                source: "image://theme/icon-cover-next"
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: moveRightButtonClicked()
            }
        }
    }

}

