
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class dbHelper{
  Database? database;

  Future check() async{
    if(database!=null)
    {
      return database;
    }else
    {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "table.db");
    return openDatabase(path,version: 1,
      onCreate: (db, version) {
        String query = "CREATE TABLE incomeexpense(id INTEGER PRIMARY KEY AUTOINCREMENT,amount TEXT,category TEXT, date TEXT,time TEXT,status INTEGER,notes TEXT,paytype TEXT)";
        db.execute(query);
      },
    );
  }

  Future<void> insert({required amount,required category,required status,required notes,required date,required time,required paytype}) async {
    database = await check();
    database!.insert("incomeexpense", {
      "amount" : amount,
      "category": category,
      "status": status,
      "notes": notes,
      "paytype": paytype,
      "date":date,
      "time": time,
    });
  }

  Future<List<Map>> read() async {
    database = await check();
    String query = "SELECT*FROM incomeexpense";
    List<Map> readList = await database!.rawQuery(query);
    return readList;
  }

  Future<void> delete({required id}) async {
    database = await check();
    database!.delete("incomeexpense",where: "id=?",whereArgs: [id]);
  }

  Future<void> update({required id,required amount,required category,required status,required notes,required date,required time,required paytype}) async {
    database = await check();
    database!.update("incomeexpense",{
      "category":category,
      "amount" : amount,
      "status": status,
      "notes": notes,
      "paytype": paytype,
      "date":date,
      "time": time,
    },where: "id=?",whereArgs: [id]);
  }

  Future<List<Map>> incomeFilter({required status})
  async {
    database = await check();
    String s1 = "SELECT * FROM incomeexpense ORDER BY id DESC";
    List<Map> list = await database!.rawQuery(s1);
    return list;
  }

}