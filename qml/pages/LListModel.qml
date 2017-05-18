import QtQuick 2.0
import Sailfish.Silica 1.0
import SortFilterProxyModel 0.2


SortFilterProxyModel {
    id: lModel
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
        AnyOf {
            RegExpFilter { // Default sorting by #1,#2 ...
                roleName: "ttitle"
                pattern: "([^#0-9]+)"
                caseSensitivity: Qt.CaseInsensitive
            }
        }
    ]
    sorters: [
        RoleSorter { roleName: "ttitle"; ascendingOrder: true } //highest order always
    ]

}





