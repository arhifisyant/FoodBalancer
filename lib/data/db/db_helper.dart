import 'package:food_balancer/data/model/food_daily_model.dart';
import 'package:food_balancer/data/model/food_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class DbHelper {
  //dibawah ini spesifikasi database sqlitenya
  static final _dbName = "foodbalancer.db";
  static final _dbVers = 2;
  static final table = "foodtable";
  static final dailyTable = "dailytable";

  //dibawah ini deklarasi nama kolom di tabel pertama dan kedua
  static final columnId = 'id';
  static final columnTitle = 'title';
  static final columnType = 'type';
  static final columnMainFood = "mainFood";
  static final columnSideDish = "sideDish";
  static final columnVegetable = "vegetable";
  static final columnFruit = "fruit";

  DbHelper._privateConstructor(){
      tbFoodTransaction = TbFoodHelper(instances: this);
      tbDailyFoodTransaction = TbDailyFoodHelper(instances: this);
  }

  static final instances = DbHelper._privateConstructor();
  static Database? _database;

  late TbFoodHelper tbFoodTransaction;
  late TbDailyFoodHelper tbDailyFoodTransaction;

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

    //isi data default sebagai percontohan ke tabel satu
    await db.insert(DbHelper.table, FoodModel(title: "Nasi", type: FoodType.MAIN_FOOD).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Nasi Kuning", type: FoodType.MAIN_FOOD).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Nasi Gurih", type: FoodType.MAIN_FOOD).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Roti Tawar", type: FoodType.MAIN_FOOD).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Getuk", type: FoodType.MAIN_FOOD).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Growol", type: FoodType.MAIN_FOOD).toMap());

    await db.insert(DbHelper.table, FoodModel(title: "Telur Dadar", type: FoodType.SIDE_DISH).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Tahu Bacem", type: FoodType.SIDE_DISH).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Tahu Goreng", type: FoodType.SIDE_DISH).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Tempe Goreng", type: FoodType.SIDE_DISH).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Ayam Goreng", type: FoodType.SIDE_DISH).toMap());

    await db.insert(DbHelper.table, FoodModel(title: "Oseng Kangkung", type: FoodType.VEGETABLE).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Sayur Asem", type: FoodType.VEGETABLE).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Sayur Gori", type: FoodType.VEGETABLE).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Daun Pepaya", type: FoodType.VEGETABLE).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Oseng Cang Panjang", type: FoodType.VEGETABLE).toMap());

    await db.insert(DbHelper.table, FoodModel(title: "Pisang", type: FoodType.FRUIT).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Pepaya", type: FoodType.FRUIT).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Sawo", type: FoodType.FRUIT).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Belimbing", type: FoodType.FRUIT).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Nanas", type: FoodType.FRUIT).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Jeruk", type: FoodType.FRUIT).toMap());
    await db.insert(DbHelper.table, FoodModel(title: "Semangka", type: FoodType.FRUIT).toMap());

    //isi data ke tabel dua
    await db.insert(DbHelper.dailyTable, FoodDailyModel(mainFood: "Getuk", sideDish: "Telur Dadar", vegetable: "Oseng Kangkung", fruit: "Pisang").toMap());
    await db.insert(DbHelper.dailyTable, FoodDailyModel(mainFood: "Nasi", sideDish: "Tahu Bacem", vegetable: "Sayur Asem", fruit: "Pepaya").toMap());
    await db.insert(DbHelper.dailyTable, FoodDailyModel(mainFood: "Nasi Gurih", sideDish: "Tahu Bacem", vegetable: "Sayur Gori", fruit: "Jeruk").toMap());
    await db.insert(DbHelper.dailyTable, FoodDailyModel(mainFood: "Roti Tawar", sideDish: "Telur Dadar", vegetable: "Daun Pepaya", fruit: "Nanas").toMap());
    await db.insert(DbHelper.dailyTable, FoodDailyModel(mainFood: "Nasi", sideDish: "Tempe Goreng", vegetable: "Oseng Cang Panjang", fruit: "Belimbing").toMap());
    await db.insert(DbHelper.dailyTable, FoodDailyModel(mainFood: "Nasi", sideDish: "Tempe Goreng", vegetable: "Daun Pepaya", fruit: "Semangka").toMap());
    await db.insert(DbHelper.dailyTable, FoodDailyModel(mainFood: "Nasi Kuning", sideDish: "Ayam Goreng", vegetable: "Sayur Asem", fruit: "Pisang").toMap());

  }
}

class TbFoodHelper{
  late DbHelper instances;
  TbFoodHelper({required this.instances});

  Future<int> insert(FoodModel task) async {
    Database? db = await instances.database;
    var res = await db.insert(DbHelper.table, task.toMap());
    return res;
  }

  Future<int> update(FoodModel task) async {
    Database? db = await instances.database;
    var res = await db.update(DbHelper.table, task.toMap(), where: '${DbHelper.columnId} = ?', whereArgs: [task.id]);
    print("result is ${res}");
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllbased(String category) async {
    Database? db = await instances.database;
    var res = await db.query(DbHelper.table, orderBy: "${DbHelper.columnId} DESC", where: "${DbHelper.columnType} LIKE ?", whereArgs: [category]);
    return res;
  }

   Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instances.database;
    var res = await db.query(DbHelper.table, orderBy: "${DbHelper.columnId} DESC");
    return res;
  }

  Future<int> delete(int id) async{
    Database db = await instances.database;
    var res = await db.delete(DbHelper.table, where: '${DbHelper.columnId} = ?', whereArgs: [id]);
    return res;
  }

  Future<void> clearTable() async {
    Database db = await instances.database;
    var res = await db.rawQuery("DELETE FROM ${DbHelper.table}");
  }
}

class TbDailyFoodHelper {
  late DbHelper instances;
  TbDailyFoodHelper({required this.instances});

  Future<int> insert(FoodDailyModel task) async {
    Database? db = await instances.database;
    var res = await db.insert(DbHelper.dailyTable, task.toMap());
    return res;
  }

  Future<int> update(FoodDailyModel task) async {
    Database? db = await instances.database;
    var res = await db.update(DbHelper.dailyTable, task.toMap(), where: '${DbHelper.columnId} = ?', whereArgs: [task.id]);
    print("result is ${res}");
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instances.database;
    var res = await db.query(DbHelper.dailyTable, orderBy: "${DbHelper.columnId} DESC");
    return res;
  }

  Future<int> delete(int id) async{
    Database db = await instances.database;
    var res = await db.delete(DbHelper.dailyTable, where: '${DbHelper.columnId} = ?', whereArgs: [id]);
    return res;
  }

  Future<void> clearTable() async {
    Database db = await instances.database;
    var res = await db.rawQuery("DELETE FROM ${DbHelper.dailyTable}");
  }

  Future<int> insertMultipleData(List<FoodDailyModel> data) async {
    Database db = await instances.database;
    var strQueryValues = data.map((e) => "(${e.id}, '${e.mainFood}', '${e.sideDish}', '${e.vegetable}', '${e.fruit}')").join(",");
    print("data is $strQueryValues");
    var res = await db.rawInsert('''
    INSERT INTO ${DbHelper.dailyTable}(
      ${DbHelper.columnId},
      ${DbHelper.columnMainFood},
      ${DbHelper.columnSideDish},
      ${DbHelper.columnVegetable},
      ${DbHelper.columnFruit}
    ) VALUES $strQueryValues
    ''');
    return res;
  }
}
