.pragma library

WorkerScript.onMessage = function(todoItem)
{





//    function openDB()
//    {
//        _db = openDatabaseSync("TodoDB","1.0","the Todo related Database",1000000);
//        createTable();
//    }

//    function createTable()
//    {
//        _db.transaction(
//                    function(tx){
//                        tx.executeSql("CREATE TABLE IF NOT EXISTS todo (id INTEGER PRIMARY KEY AUTOINCREMENT, box INTEGER, done TEXT, title TEXT, note TEXT, modified TEXT)");
//                    }
//                    )
//    }


    var _db;
    _db = openDatabaseSync("TodoDB","1.0","the Todo related Database",1000000);
    _db.transaction(
                function(tx){
                    tx.executeSql("UPDATE todo SET BOX = ? , done = ?, \
                                  title = ?, note = ?, modified = ?  \
                                  WHERE id = ?", [todoItem.box, todoItem.done, todoItem.title, todoItem.note, todoItem.modified, todoItem.id]);
                }
                )
}
