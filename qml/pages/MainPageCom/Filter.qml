import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: filterPage

    property var model

    SilicaFlickable {
        width: parent.width
        height: parent.height
        contentHeight: mainColumn.height + head.height

        PageHeader {
            id: head
            title: qsTr("Filter")
        }

        Column {
            id: mainColumn
            spacing: Theme.paddingSmall
            width: parent.width
            anchors.top: head.bottom
            TextArea {
                id: desc
                background: null
                wrapMode: TextEdit.WordWrap
                width: parent.width
                readOnly: true
                text: qsTr("Elements in the list are sorted by default based on the time they were added. You can give priority by adding #NUMBER.
The lower the number the higher the priority")
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
            }
            SectionHeader {
                id: impSecHead
                text: qsTr("Importance")
            }
            Item {
                width: parent.width
                height: impSwitch.height + (2 * Theme.paddingMedium)
                Rectangle {
                    id: impRect
                    color: "red"
                    height: impSwitch.height
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingMedium
                }
                TextSwitch {
                    id: impSwitch
                    text: qsTr("important")
                    anchors.left: impRect.right
                    anchors.leftMargin: Theme.paddingMedium
                    checked: model.filterIsImportant || model.tcatColor1 == "red"
                    onCheckedChanged: {
                        if (checked) model.filterIsImportant = true
                        else model.filterIsImportant = false
                    }
                }
            }
            SectionHeader {
                id: dueSecHead
                text: qsTr("Due")
            }
            Item {
                width: parent.width
                height: impSwitch.height + (2 * Theme.paddingMedium)
                Rectangle {
                    id: todRect
                    color: "orange"
                    height: impSwitch.height
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingMedium
                }
                TextSwitch {
                    id: todSwitch
                    text: qsTr("today")
                    checked: model.filterIsDueToday || model.tcatColor2 == "orange"
                    anchors.left: todRect.right
                    anchors.leftMargin: Theme.paddingMedium
                    onCheckedChanged: {
                        if (checked) {
                            model.filterIsDueToday = true
                            thiswSwitch.checked = false
                            somSwitch.checked = false
                        }
                        else model.filterIsDueToday = false
                    }
                }
            }
            Item {
                width: parent.width
                height: impSwitch.height + (2 * Theme.paddingMedium)
                Rectangle {
                    id: thiswRect
                    color: "cyan"
                    height: impSwitch.height
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingMedium
                }
                TextSwitch {
                    id: thiswSwitch
                    text: qsTr("this week")
                    checked: model.filterIsDueThisWeek || model.tcatColor2 == "cyan"
                    anchors.left: thiswRect.right
                    anchors.leftMargin: Theme.paddingMedium
                    onCheckedChanged: {
                        if (checked) {
                            model.filterIsDueThisWeek = true
                            todSwitch.checked = false
                            somSwitch.checked = false
                        }
                        else model.filterIsDueThisWeek = false
                    }
                }
            }
            Item {
                width: parent.width
                height: impSwitch.height + (2 * Theme.paddingMedium)
                Rectangle {
                    id: somRect
                    color: "yellow"
                    height: impSwitch.height
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingMedium
                }
                TextSwitch {
                    id: somSwitch
                    text: qsTr("someday")
                    checked: model.filterIsDueSometimes || model.tcatColor2 == "yellow"
                    anchors.left: somRect.right
                    anchors.leftMargin: Theme.paddingMedium
                    onCheckedChanged: {
                        if (checked) {
                            model.filterIsDueSometimes = true
                            todSwitch.checked = false
                            thiswSwitch.checked = false
                        }
                        else model.filterIsDueSometimes = false
                    }
                }
            }
            SectionHeader {
                id: catSecHead
                text: qsTr("Category")
            }
            Item {
                width: parent.width
                height: impSwitch.height + (2 * Theme.paddingMedium)
                Rectangle {
                    id: perRect
                    color: "green"
                    height: impSwitch.height
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingMedium
                }
                TextSwitch {
                    id: perSwitch
                    text: qsTr("personal")
                    checked: model.filterIsPersonal || model.tcatColor3 == "green"
                    anchors.left: perRect.right
                    anchors.leftMargin: Theme.paddingMedium
                    onCheckedChanged: {
                        if (checked) {
                            model.filterIsPersonal = true
                            worSwitch.checked = false
                        }
                        else model.filterIsPersonal = false
                    }
                }
            }
            Item {
                width: parent.width
                height: impSwitch.height + (2 * Theme.paddingMedium)
                Rectangle {
                    id: worRect
                    color: "blue"
                    height: impSwitch.height
                    width: height
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingMedium
                }
                TextSwitch {
                    id: worSwitch
                    text: qsTr("work")
                    checked: model.filterIsWork || model.tcatColor2 == "blue"
                    anchors.left: worRect.right
                    anchors.leftMargin: Theme.paddingMedium
                    onCheckedChanged: {
                        if (checked) {
                            model.filterIsWork = true
                            perSwitch.checked = false
                        }
                        else model.filterIsWork = false
                    }
                }
            }

        } // Column
    } // Flickable
} // Page
