
WorkerScript.onMessage = function xxxx(todoItem)
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
                    tx.executeSql("INSERT INTO todo (box, done, title, note, modified) VALUES(?,?,?,?,?)",[todoItem.box, todoItem.done, todoItem.title, todoItem.note, Qt.formatDateTime(new Date(), ("d MMM yyyy h:m:s AP")) ]);
                }
                )
    WorkerScript.sendMessage()
}

