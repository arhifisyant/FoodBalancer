import 'package:food_balancer/data/db/db_helper.dart';
import 'package:food_balancer/data/model/daily_food.dart';
//import 'package:food_balancer/data/model/task.dart';
import 'package:get/get.dart';
//import 'package:sqflite/sqlite_api.dart';

class WeeklyFoodControlelr extends GetxController {

  static const DAY_IN_A_WEEK = 7;

  var task = List<DailyFoodModel>.empty().obs;
  set postTask(List<DailyFoodModel> data) => task.value = data;
  List<DailyFoodModel> get getTask => task.value;

  @override
  void onInit() {
    _getData();
    super.onInit();
  }

  _getData() {
    DatabaseHelper.instances.dbDailyFoodTransaction.queryAll()
    .then((value) => value.map((e) => DailyFoodModel(id: e['id'], mainFood: e['mainFood'], sideDish: e['sideDish'], vegitable: e['vegetable'], fruit: e['fruit'])).toList())
    .then((value) {
      value.forEach((element) {print("data value is ${element.mainFood}");});
      if(value.isEmpty) {
        DatabaseHelper.instances.dbDailyFoodTransaction.insertMultipleData(_createDefaultData());
      } else {
        return value;
      }
    })
    .then((value) {    
      return postTask = value!;
    });
  }

  List<DailyFoodModel> _createDefaultData() {
    return List.filled(DAY_IN_A_WEEK, 
      DailyFoodModel()
    );
  }

}