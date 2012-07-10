

.pragma library

var _db;

function openDB()
{
    _db = openDatabaseSync("TodoDB","1.0","the Todo related Database",1000000);
    createTable();
}

function createTable()
{
    _db.transaction(
                function(tx){
                    tx.executeSql("CREATE TABLE IF NOT EXISTS todo (id INTEGER PRIMARY KEY AUTOINCREMENT, box INTEGER, done TEXT, title TEXT, note TEXT, modified TEXT)");
                }
                )
}

function saveSetting(data, read, name){

    openDB()
    _db.transaction(
                function(tx){
                    tx.executeSql("CREATE TABLE IF NOT EXISTS setting (name TEXT UNIQUE, value TEXT)");
                }
                )

    if(!read){
        _db.transaction(
                    function(tx){
                        tx.executeSql("INSERT OR REPLACE INTO setting (name,value) VALUES(?,?)",[data.name , data.value]);
                    }
                    )
    }
    else{
        var rs
        _db.readTransaction(
                    function(tx){
                        rs = tx.executeSql("SELECT * FROM setting WHERE name =?", [name]);
                    }
                    )

        if(rs.rows.length>0){
            console.log(rs.rows.length)
        return rs.rows.item(0).value
        }
        else
            return "./images/bg2.jpg"
    }
}

function dropTable()
{
    _db.transaction(
                function(tx){
                    tx.executeSql("DROP TABLE IF EXISTS todo");
                }
                )
    _db.transaction(
                function(tx){
                    tx.executeSql("DROP TABLE IF EXISTS setting");
                }
                )
}

function readTodos()
{
    var data = [];
    _db.readTransaction(
                function(tx){
                    var rs = tx.executeSql("SELECT * FROM todo ORDER BY modified DESC");
                    for (var i=0; i< rs.rows.length; i++) {
                        data[i] = rs.rows.item(i);
                    }

                }
                )
    return data;
}

function readId()
{
    var data
    var ret
    _db.readTransaction(
                function(tx){
                    var rs = tx.executeSql("SELECT * FROM todo ORDER BY id DESC");
                    if(rs.rows.length > 0) {
                        data = rs.rows.item(0);
                        ret = data.id
                    }
                    else ret = 0

                }
                )
    //var didd = data[0]
    return ret // data.id
    //return data[0];
}

function updateTodo(todoItem)
{
    _db.transaction(
                function(tx){
                    tx.executeSql("UPDATE todo SET BOX = ? , done = ?, \
                                  title = ?, note = ?, modified = ?  \
                                  WHERE id = ?", [todoItem.box, todoItem.done, todoItem.title, todoItem.note, todoItem.modified, todoItem.id]);
                }
                )
}

function deleteTodo(id)
{
    _db.transaction(
                function(tx){
                    tx.executeSql("DELETE FROM todo WHERE id = ?", [id]);
                }
                )
}

function createTodo(todoItem)
{
    _db.transaction(
                function(tx){
                    tx.executeSql("INSERT INTO todo (box, done, title, note, modified) VALUES(?,?,?,?,?)",[todoItem.box, todoItem.done, todoItem.title, todoItem.note, todoItem.modified]);
                }
                )
}

function readTodoBox(model, box)
{
    model.clear()
    _db.readTransaction(
                function(tx){
                    var rs = tx.executeSql("SELECT * FROM todo WHERE box =? ORDER BY modified DESC", [box]);
                    for (var i=0; i< rs.rows.length; i++) {
                        model.append(rs.rows.item(i))
                    }
                }
                )
}

function readTodoItem(todoId) {
    var data = {}
    _db.readTransaction(
                function(tx){
                    var rs = tx.executeSql("SELECT * FROM todo WHERE id=?", [todoId])
                    if(rs.rows.length === 1) {
                        data = rs.rows.item(0)
                        //data.done = data.done===0?false:true
                        //data.modified = new Date(data.modified)
                    }
                }
                )
    return data;
}

function printObject(o)
{
    print(Object.keys(o))
    for(var key in o) {
        print("  " + key +"="+o[key])
    }

}

function countBox(boxId)
{
    var data = 0;
    _db.readTransaction(
                function(tx){
                    var rs = tx.executeSql("SELECT count(*) FROM todo WHERE box = ?",[boxId]);
                    if(rs.rows.length === 1) {
                        data = rs.rows.item(0)["count(*)"]
                    }

                }
                )
    return data;


}

function createBatchTodos(data)
{
    _db.transaction(
                function(tx){
                    for(var i=0; i<data.length; i++) {
                        var item = data[i]
                        tx.executeSql("INSERT INTO todo (box, done, title, note, modified) VALUES(?,?,?,?,?)",[item.box, item.done, item.title, item.note, item.modified]);
                    }
                }
                )
}

function clearArchive(model)
{
    model.clear()
    _db.transaction(
                function(tx){
                    tx.executeSql("DELETE FROM todo WHERE box = 4");
                }
                )
}

function updateArchive(box)
{
    _db.transaction(
                function(tx){
                    tx.executeSql("UPDATE todo SET box = 4 WHERE done = 'true' AND box=?",[box]);
                }
                )
}

function defaultItem()
{
    return {box: 0, done: false, title: "", note: "", modified: Qt.formatDateTime(new Date(), ("d MMM yyyy h:m AP")) }
}
