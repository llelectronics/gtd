import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog {
    id: createTodo

    property bool isNew: false // New Todo or Edit Todo

    property string ttitle
    property string tcatColor1
    property string tcatColor2
    property string tcatColor3
    property string tmoveRightIcon
    property string tid
    property string tnote

    property bool filterIsImportant: false
    property bool filterIsDueToday: false
    property bool filterIsDueThisWeek: false
    property bool filterIsDueSometimes: false
    property bool filterIsWork: false
    property bool filterIsPersonal: false

    onFilterIsImportantChanged: {
        if (filterIsImportant) tcatColor1 = "red"
        else tcatColor1 = ""
    }
    onFilterIsDueTodayChanged: {
        if (filterIsDueToday) tcatColor2 = "orange"
        else if (filterIsDueThisWeek) return
        else if (filterIsDueSometimes) return
        else tcatColor2 = ""
    }
    onFilterIsDueThisWeekChanged: {
        if (filterIsDueThisWeek) tcatColor2 = "cyan"
        else if (filterIsDueToday) return
        else if (filterIsDueSometimes) return
        else tcatColor2 = ""
    }
    onFilterIsDueSometimesChanged: {
        if (filterIsDueSometimes) tcatColor2 = "yellow"
        else if (filterIsDueToday) return
        else if (filterIsDueThisWeek) return
        else tcatColor2 = ""
    }
    onFilterIsPersonalChanged: {
        if (filterIsPersonal) tcatColor3 = "green"
        else if (filterIsWork) return
        else tcatColor3 = ""
    }
    onFilterIsWorkChanged: {
        if (filterIsWork) tcatColor3 = "blue"
        else if (filterIsPersonal) return
        else tcatColor3 = ""
    }

    SilicaFlickable {
        width: parent.width
        height: parent.height - head.height
        anchors.top: parent.top
        contentHeight: mainColumn.height

        DialogHeader {
            id: head
        }

        Column {
            id: mainColumn
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: head.height

            spacing: Theme.paddingSmall

            TextField {
                id: todoTitle
                text: ttitle
                placeholderText: qsTr("Todo Title")
                label: qsTr("Title of Todo")
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingSmall
                color: Theme.primaryColor
                readOnly: false
                height: Theme.itemSizeMedium
                width: parent.width - (2* Theme.paddingSmall)
            }

            BackgroundItem {
                id: propertiesBtn
                width: parent.width
                height: propertiesLbl.height + Theme.itemSizeSmall
                onClicked: pageStack.push(Qt.resolvedUrl("Filter.qml"), { model: createTodo })
                Label {
                    id: propertiesLbl
                    text: qsTr("Properties")
                    font.bold: true
                    width: parent.width - (2* Theme.paddingMedium)
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.paddingLarge
                }
                Item {
                    id: tcatColor1Indicator
                    anchors.left: parent.left
                    anchors.top: propertiesLbl.bottom
                    anchors.leftMargin: Theme.paddingLarge
                    anchors.topMargin: Theme.paddingMedium
                    width: (parent.width / 3) - (2* Theme.paddingMedium)
                    Rectangle {
                        id: tcatColor1Rect
                        color: tcatColor1 != "" ? tcatColor1 : "transparent"
                        width: Theme.iconSizeSmall
                        height: width
                    }
                    Label {
                        text: tcatColor1 == "red" ? qsTr("Important") : ""
                        width: (parent.width / 3) - (4* Theme.paddingMedium)
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.secondaryColor
                        anchors.left: tcatColor1Rect.right
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.verticalCenter: tcatColor1Rect.verticalCenter
                    }
                }
                Item {
                    id: tcatColor2Indicator
                    anchors.left: tcatColor1Indicator.right
                    anchors.top: propertiesLbl.bottom
                    anchors.leftMargin: Theme.paddingMedium
                    anchors.topMargin: Theme.paddingMedium
                    width: (parent.width / 3) - (2* Theme.paddingMedium)
                    Rectangle {
                        id: tcatColor2Rect
                        color: tcatColor2 != "" ? tcatColor2 : "transparent"
                        width: Theme.iconSizeSmall
                        height: width
                    }
                    Label {
                        text: {
                            if (tcatColor2 == "orange") qsTr("Today")
                            else if (tcatColor2 == "cyan") qsTr("This Week")
                            else if (tcatColor2 == "yellow") qsTr("Someday")
                            else ""
                        }
                        width: (parent.width / 3) - (4* Theme.paddingMedium)
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.secondaryColor
                        anchors.left: tcatColor2Rect.right
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.verticalCenter: tcatColor2Rect.verticalCenter
                    }
                }
                Item {
                    id: tcatColor3Indicator
                    anchors.left: tcatColor2Indicator.right
                    anchors.top: propertiesLbl.bottom
                    anchors.leftMargin: Theme.paddingMedium
                    anchors.topMargin: Theme.paddingMedium
                    width: (parent.width / 3) - (2* Theme.paddingMedium)
                    Rectangle {
                        id: tcatColor3Rect
                        color: tcatColor3 != "" ? tcatColor3 : "transparent"
                        width: Theme.iconSizeSmall
                        height: width
                    }
                    Label {
                        text: {
                           if (tcatColor3 == "green") qsTr("Personal")
                           else if (tcatColor3 == "blue") qsTr("Work")
                           else ""
                        }
                        width: (parent.width / 3) - (4* Theme.paddingMedium)
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.secondaryColor
                        anchors.left: tcatColor3Rect.right
                        anchors.leftMargin: Theme.paddingSmall
                        anchors.verticalCenter: tcatColor3Rect.verticalCenter
                    }
                }
            } // BackgroundItem
            SectionHeader {
                text: qsTr("Notes")
            }

            TextArea {
                id: tnoteText
                text: tnote
                width: parent.width - (2* Theme.paddingMedium)
                height: (createTodo.height / 2) - tnoteButtonSwitch.height
                property bool isHtml: false
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingMedium
                background: null
            }
            Button {
                id: tnoteButtonSwitch
                text: tnoteText.isHtml ? qsTr("Show Text") : qsTr("Show HTML")
                width: parent.width - (2* Theme.paddingMedium)
                anchors.horizontalCenter: parent.horizontalCenter
            }

        } // Column
    }
}

