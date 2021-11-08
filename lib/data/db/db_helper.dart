import 'package:flutter/foundation.dart';
import 'package:food_balancer/data/model/daily_food.dart';
import 'package:food_balancer/data/model/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = "task.db";
  static final _dbVers = 2;
  static final table = "food";
  static final dailyTable = "dailyTable";

  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnType = 'type';

  static final columnMainFood = "mainFood";
  static final columnSideDish = "sideDish";
  static final columnVegetable = "vegetable";
  static final columnFruit = "fruit";

  DatabaseHelper._privateConstructor(){
     dbMainFoodTransacktion = DbMainFoodTransaction(instances: this);
    dbDailyFoodTransaction = DbDailyFoodTransaction(instances: this);
  }

  static final instances = DatabaseHelper._privateConstructor();

  static Database? _database;
  late DbMainFoodTransaction dbMainFoodTransacktion;
  late DbDailyFoodTransaction dbDailyFoodTransaction;

  Future<Database> get database async {
    return _database ?? await _initDatabase();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVers, onCreate: _onCreate);
  }
  
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTitle FLOAT NOT NULL,
      $columnType FLOAT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE $dailyTable(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnMainFood FLOAT NOT NULL,
      $columnSideDish FLOAT NOT NULL,
      $columnVegetable FLOAT NOT NULL,
      $columnFruit FLOAT NOT NULL
    )
    ''');
  }
}

class DbDailyFoodTransaction {
  late DatabaseHelper instances;
  DbDailyFoodTransaction({required this.instances});

Future<int> insert(DailyFoodModel task) async {
    Database? db = await instances.database;
    var res = await db.insert(DatabaseHelper.dailyTable, task.toMap());
    return res;
  }

  Future<int> update(DailyFoodModel task) async {
    Database? db = await instances.database;
    var res = await db.update(DatabaseHelper.dailyTable, task.toMap(), where: '${DatabaseHelper.columnId} = ?', whereArgs: [task.id]);
    print("result is ${res}");
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instances.database;
    var res = await db.query(DatabaseHelper.dailyTable, orderBy: "${DatabaseHelper.columnId} DESC");
    return res;
  }

  Future<int> delete(int id) async{
    Database db = await instances.database;
    var res = await db.delete(DatabaseHelper.dailyTable, where: '${DatabaseHelper.columnId} = ?', whereArgs: [id]);
    return res;
  }

  Future<void> clearTable() async {
    Database db = await instances.database;
    var res = await db.rawQuery("DELETE FROM ${DatabaseHelper.dailyTable}");
  }

  Future<int> insertMultipleData(List<DailyFoodModel> data) async {
    Database db = await instances.database;
    var strQueryValues = data.map((e) => "(${e.id}, '${e.mainFood}', '${e.sideDish}', '${e.vegitable}', '${e.fruit}')").join(",");
    print("data is $strQueryValues");
    var res = await db.rawInsert('''
    INSERT INTO ${DatabaseHelper.dailyTable}(
      ${DatabaseHelper.columnId},
      ${DatabaseHelper.columnMainFood},
      ${DatabaseHelper.columnSideDish},
      ${DatabaseHelper.columnVegetable},
      ${DatabaseHelper.columnFruit}
    ) VALUES $strQueryValues
    ''');
    return res;
  }

}

class DbMainFoodTransaction{
  late DatabaseHelper instances;
  DbMainFoodTransaction({required this.instances});

  Future<int> insert(TaskData task) async {
    Database? db = await instances.database;
    var res = await db.insert(DatabaseHelper.table, task.toMap());
    return res;
  }

  Future<int> update(TaskData task) async {
    Database? db = await instances.database;
    var res = await db.update(DatabaseHelper.table, task.toMap(), where: '${DatabaseHelper.columnId} = ?', whereArgs: [task.id]);
    print("result is ${res}");
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllbased(String category) async {
    Database? db = await instances.database;
    var res = await db.query(DatabaseHelper.table, orderBy: "${DatabaseHelper.columnId} DESC", where: "${DatabaseHelper.columnType} LIKE ?", whereArgs: [category]);
    return res;
  }

   Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instances.database;
    var res = await db.query(DatabaseHelper.table, orderBy: "${DatabaseHelper.columnId} DESC");
    return res;
  }

  Future<int> delete(int id) async{
    Database db = await instances.database;
    var res = await db.delete(DatabaseHelper.table, where: '${DatabaseHelper.columnId} = ?', whereArgs: [id]);
    return res;
  }

  Future<void> clearTable() async {
    Database db = await instances.database;
    var res = await db.rawQuery("DELETE FROM ${DatabaseHelper.table}");
  }
}