import QtQuick 2.0
import Sailfish.Silica 1.0


ListModel {
    id: lModel

    function rm(ident) {
        for (var i=0; i<count; i++) {
            if (get(i).tid == ident)  {
                remove(i)
            }
        }
        return;
    }
}





