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

            if(todoItem.arg == "create"){
                try{
                _db.transaction(
                            function(tx){
                                tx.executeSql("INSERT INTO todo (box, done, title, note, modified) VALUES(?,?,?,?,?)",[todoItem.box, todoItem.done, todoItem.title, todoItem.note, Qt.formatDateTime(new Date(), ("d MMM yyyy h:m:s AP")) ]);
                            }
                            )
                }catch(e){
                    console.log(JSON.stringify(e))
                }
            }

            if(todoItem.arg == "read"){
                todoItem.model.clear()
                _db.readTransaction(
                            function(tx){
                                var rs = tx.executeSql("SELECT * FROM todo WHERE box =? ORDER BY modified DESC", [todoItem.box]);
                                for (var i=0; i< rs.rows.length; i++) {
                                    todoItem.model.append(rs.rows.item(i))
                                }
                            }
                            )
                todoItem.model.sync()
            }

            if(todoItem.arg == "update"){

    _db.transaction(
                function(tx){
                    tx.executeSql("UPDATE todo SET BOX = ? , done = ?, \
                                  title = ?, note = ?, modified = ?  \
                                  WHERE id = ?", [todoItem.box, todoItem.done, todoItem.title, todoItem.note, Qt.formatDateTime(new Date(), ("d MMM yyyy h:m:s AP"))+"", todoItem.id]);
                }
                )
            }
}
