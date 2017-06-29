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

    function contains(ident) {
        for (var i=0; i<count; i++) {
            if (get(i).tid == ident)  { // type transformation is intended here
                return true;
            }
        }
        return false;
    }

    function addTodo(tid,ttitle,tcatColor1,tcatColor2,tcatColor3,tmoveRightIcon,tnote,taudio,timage,lid) {
        if (contains(tid)) rm(tid);
        if (mainWindow.isEmpty(tcatColor1)) tcatColor1 = "";
        if (mainWindow.isEmpty(tcatColor2)) tcatColor2 = "";
        if (mainWindow.isEmpty(tcatColor3)) tcatColor3 = "";
        if (mainWindow.isEmpty(taudio)) taudio = "";
        if (mainWindow.isEmpty(timage)) timage = "";
        if (mainWindow.isEmpty(tnote)) tnote = "";
        if (mainWindow.isEmpty(tmoveRightIcon)) tmoveRightIcon = "";
        append({
                                 tid: tid, //uniq
                                 ttitle: ttitle,
                                 tcatColor1: tcatColor1,  // reserved for important
                                 tcatColor2: tcatColor2, // due
                                 tcatColor3: tcatColor3, // personal or work related
                                 tmoveRightIcon: tmoveRightIcon,
                                 tnote: tnote,
                                 taudio: taudio,
                                 timage: timage,
                                 lid: lid
                             });
    }

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





