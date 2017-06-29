//db.js
.import QtQuick.LocalStorage 2.0 as LS
// First, let's create a short helper function to get the database connection
function getDatabase() {
    return LS.LocalStorage.openDatabaseSync("harbour-gtd", "", "StorageDatabase", 100000);
}

// At the start of the application, we can initialize the tables we need if they haven't been created yet
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx,er) {
                    // Create the bookmarks table if it doesn't already exist
                    // If the table exists, this is skipped
                    tx.executeSql('CREATE TABLE IF NOT EXISTS List(lid INTEGER, lname TEXT)');
                    tx.executeSql('CREATE UNIQUE INDEX IF NOT EXISTS lidx ON List(lid)');
                    var table  = tx.executeSql("SELECT * FROM List");
                    // Insert default bookmarks if no bookmarks are set / empty bookmarks db
                    if (table.rows.length === 0) {
                        tx.executeSql('INSERT INTO List VALUES (?,?);', [0, "todo"]);
                        tx.executeSql('INSERT INTO List VALUES (?,?);', [1, "doing"]);
                        tx.executeSql('INSERT INTO List VALUES (?,?);', [2, "done"]);
                        tx.executeSql('INSERT INTO List VALUES (?,?);', [3, "read_it_later"]);
                    }
                    tx.executeSql('CREATE TABLE IF NOT EXISTS todos(tid TEXT, ttitle TEXT, tcatColor1 TEXT, tcatColor2 TEXT, tcatColor3 TEXT, tmoveRightIcon TEXT, tnote TEXT, taudio TEXT, timage TEXT, lid INTEGER)');
                    tx.executeSql('CREATE UNIQUE INDEX IF NOT EXISTS tidx ON todos(tid)');
                });
}

// This function is used to write todo into the database
function addTodo(tid,ttitle,tcatColor1,tcatColor2,tcatColor3,tmoveRightIcon,tnote,taudio,timage,lid) {
    var date = new Date();
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO todos VALUES (?,?,?,?,?,?,?,?,?,?);', [tid,ttitle,tcatColor1,tcatColor2,tcatColor3,tmoveRightIcon,tnote,taudio,timage,lid]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Saved to database");
        } else {
            res = "Error";
            console.log ("Error saving to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

// This function is used to remove todo from the database
function removeTodo(tid,lid) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM todos WHERE tid=(?) AND lid=(?);', [tid,lid]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Removed todo from database");
        } else {
            res = "Error";
            console.log ("Error removing from database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

function isEmpty(str) {
    return (!str || 0 === str.length);
}

function getTodos(lid,tlist) {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM todos WHERE lid=(?);', [lid]);
        for (var i = 0; i < rs.rows.length; i++) {
            if (rs.rows.item(i).tid != null) {
                //console.debug("[db.js] History text != '' :" + rs.rows.item(i).title);
                    tlist.addTodo(rs.rows.item(i).tid,rs.rows.item(i).ttitle,rs.rows.item(i).tcatColor1,rs.rows.item(i).tcatColor2,rs.rows.item(i).tcatColor3,rs.rows.item(i).tmoveRightIcon,rs.rows.item(i).tnote,rs.rows.item(i).taudio,rs.rows.item(i).timage,rs.rows.item(i).lid);
            } else return "Error"
        }
    })
}


// TODO: BELOW //

function showHistoryLast() {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        res = tx.executeSql('SELECT history.uid FROM history ORDER BY history.uid limit (select count(*) -10 from history);');
        for (var i = 0; i < res.rows.length; i++) {
            //console.debug("showHistoryLast: " + res.rows.item(i).uid);
        }
    })
}

// This function is used to retrieve history from database
function getHistory() {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM history ORDER BY history.uid;');
        for (var i = 0; i < rs.rows.length; i++) {
            if (rs.rows.item(i).title != null) {
                //console.debug("[db.js] History text != '' :" + rs.rows.item(i).title);
                firstPage.addHistory(rs.rows.item(i).url,rs.rows.item(i).title)
            } else firstPage.addHistory(rs.rows.item(i).url,rs.rows.item(i).url)
        }
    })
}

// This function is used to write bookmarks into the database
function addBookmark(title,url) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        // Remove and readd if url already in history
        removeBookmark(url);
        //console.debug("Adding to bookmarks db:" + title + " " + url);

        var rs = tx.executeSql('INSERT OR REPLACE INTO bookmarks VALUES (?,?);', [title,url]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Saved to database");
        } else {
            res = "Error";
            console.log ("Error saving to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

// This function is used to edit bookmarks in the database
function editBookmark(oldtitle,title,url) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        console.debug("UPDATE bookmarks SET title=" + title + ", url=" + url + " WHERE title=" + oldtitle + ";")
        var rs = tx.executeSql('UPDATE bookmarks SET title=(?), url=(?) WHERE title=(?);', [title,url,oldtitle]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Saved to database");
        } else {
            res = "Error";
            console.log ("Error saving to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

// This function is used to remove a bookmark from database
function removeBookmark(url) {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM bookmarks WHERE url=(?);', [url]);
//        if (rs.rowsAffected > 0) {
//            console.debug("Url found and removed");
//        } else {
//            console.debug("Url not found");
//        }
    })
}

// This function is used to retrieve bookmarks from database
function getBookmarks() {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM bookmarks ORDER BY bookmarks.title;');
        for (var i = 0; i < rs.rows.length; i++) {
            mainWindow.modelBookmarks.append({"title" : rs.rows.item(i).title, "url" : rs.rows.item(i).url});
        }
    })
}

// This function is used to write position into the database
function addPosition(url,position) {
    var date = new Date();
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        // Remove and readd if url already in history
        var rs0 = tx.executeSql('delete from positionStore where url=(?);',[url]);
        if (rs0.rowsAffected > 0) {
            //console.debug("Url already found and removed to readd it");
        } else {
            //console.debug("Url not found so add it newly");
        }

        var rs = tx.executeSql('INSERT OR REPLACE INTO positionStore VALUES (?,?,?);', [date.getTime(),url,position]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            //console.log ("Saved to database");
        } else {
            res = "Error";
            //console.log ("Error saving to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

// This function is used to write position into the database
function getPosition(url) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT position FROM positionStore WHERE url=(?);', [url]);
    if (rs.rows.length > 0) {  // Headaches !!! Why isn't rowsAffected working here ?
        for (var i = 0; i < rs.rows.length; i++) {
            if (rs.rows.item(i).position != null) {
                //console.debug("[db.js] History text != '' :" + rs.rows.item(i).title);
                res = rs.rows.item(i).position
                return res;
            } else res = "Not Found";
        }
        } else {
            res = "Not Found";
            //console.log ("Error saving to database");
        }
    }
    );
    return res;
}

// This function is used to write settings into the database
function addSetting(setting,value) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Setting written to database");
        } else {
            res = "Error";
            console.log ("Error writing setting to database");
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

function stringToBoolean(str) {
    switch(str.toLowerCase()){
    case "true": case "yes": case "1": return true;
    case "false": case "no": case "0": case null: return false;
    default: return Boolean(string);
    }
}

function clearTable(table) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql("DELETE FROM " + table);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Cleared database table " + table);
        } else {
            res = "Error";
            console.log ("Error clearing database table " + table);
        }
    }
    );
    // The function returns “OK” if it was successful, or “Error” if it wasn't
    return res;
}

// This function is used to retrieve settings from database
function getSettings() {
    var db = getDatabase();
    var respath="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM settings;');
        for (var i = 0; i < rs.rows.length; i++) {
            if (rs.rows.item(i).setting == "enableSubtitles") mainWindow.firstPage.enableSubtitles = stringToBoolean(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "subtitlesSize") mainWindow.firstPage.subtitlesSize = rs.rows.item(i).value
            else if (rs.rows.item(i).setting == "boldSubtitles") mainWindow.firstPage.boldSubtitles = stringToBoolean(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "subtitlesColor") mainWindow.firstPage.subtitlesColor = rs.rows.item(i).value
            //else if (rs.rows.item(i).setting == "youtubeDirect") mainWindow.firstPage.youtubeDirect = stringToBoolean(rs.rows.item(i).value) // awlays on as ytapi changed api and wants money
            else if (rs.rows.item(i).setting == "openDialogType") mainWindow.firstPage.openDialogType = rs.rows.item(i).value
            else if (rs.rows.item(i).setting == "liveView") mainWindow.firstPage.liveView = stringToBoolean(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "subtitleSolid") mainWindow.firstPage.subtitleSolid = stringToBoolean(rs.rows.item(i).value)
            else if (rs.rows.item(i).setting == "ytDefaultQual") mainWindow.firstPage.ytQualWanted = rs.rows.item(i).value
            else if (rs.rows.item(i).setting == "onlyMusicState") mainWindow.firstPage.onlyMusicState = rs.rows.item(i).value
        }
    })
}
