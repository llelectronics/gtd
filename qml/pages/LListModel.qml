import QtQuick 2.0
import Sailfish.Silica 1.0
import SortFilterProxyModel 0.2


SortFilterProxyModel {
    id: lModel

    property bool filterIsImportant: false
    property bool filterIsDueToday: false
    property bool filterIsDueThisWeek: false
    property bool filterIsDueSometimes: false
    property bool filterIsWork: false
    property bool filterIsPersonal: false


    sourceModel: ListModel {
        id: sModel
    }

    function append(dictionary) { sModel.append(dictionary) }
    function remove(indexnumber) { sModel.remove(indexnumber) }

    function rm(ident) {
        for (var i=0; i<count; i++) {
            if (sModel.get(i).tid == ident)  {
                remove(i)
            }
        }
        return;
    }

    filters: [
        RegExpFilter { // Default sorting by #1,#2 ...
            roleName: "ttitle"
            pattern: "([^#0-9]+)"
            caseSensitivity: Qt.CaseInsensitive

        },
        ValueFilter {
            enabled: filterIsImportant
            roleName: "tcatColor1"
            value: "red"
        },
        ValueFilter {
            enabled: filterIsDueToday
            roleName: "tcatColor2"
            value: "orange"
        },
        ValueFilter {
            enabled: filterIsDueThisWeek
            roleName: "tcatColor2"
            value: "cyan"
        },
        ValueFilter {
            enabled: filterIsDueSometimes
            roleName: "tcatColor2"
            value: "yellow"
        },
        ValueFilter {
            enabled: filterIsWork
            roleName: "tcatColor3"
            value: "blue"
        },
        ValueFilter {
            enabled: filterIsPersonal
            roleName: "tcatColor3"
            value: "green"
        }
    ]
    sorters: [
        RoleSorter { roleName: "ttitle"; ascendingOrder: true } //highest order always
    ]

}





