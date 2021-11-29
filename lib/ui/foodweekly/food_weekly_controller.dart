import 'package:food_balancer/data/db/db_helper.dart';
import 'package:food_balancer/data/model/food_daily_model.dart';
import 'package:food_balancer/data/model/food_model.dart';
import 'package:get/get.dart';
//import 'package:sqflite/sqlite_api.dart';

class FoodWeeklyController extends GetxController {

  var task = List<FoodDailyModel>.empty().obs;
  set postTask(List<FoodDailyModel> data) => task.value = data;
  List<FoodDailyModel> get getTask => task.value;

  @override
  void onInit() {
    _getData();
    super.onInit();
  }

  _getData() { // kalau pake underscore, artinya methodnya provate, enggak pake uincerscore public
    DbHelper.instances.tbFoodDailyTransaction.queryAll()
    .then((value) => value.map((e) => FoodDailyModel(id: e['id'], mainFood: e['mainFood'], sideDish: e['sideDish'], vegetable: e['vegetable'], fruit: e['fruit'])).toList())
    .then((value) {
      postTask = value;
    });
  }

}