import 'package:food_balancer/data/db/db_helper.dart';
import 'package:food_balancer/data/model/food_daily_model.dart';
import 'package:food_balancer/data/model/food_model.dart';
import 'package:get/get.dart';
//import 'package:sqflite/sqlite_api.dart';

class WeeklyFoodController extends GetxController {

  static const DAY_IN_A_WEEK = 7;

  var task = List<FoodDailyModel>.empty().obs;
  set postTask(List<FoodDailyModel> data) => task.value = data;
  List<FoodDailyModel> get getTask => task.value;

  @override
  void onInit() {
    _getData();
    super.onInit();
  }

  _getData() {
    DbHelper.instances.tbDailyFoodTransaction.queryAll()
    .then((value) => value.map((e) => FoodDailyModel(id: e['id'], mainFood: e['mainFood'], sideDish: e['sideDish'], vegetable: e['vegetable'], fruit: e['fruit'])).toList())
    .then((value) {
      if(value.isEmpty) { // jika hasil query kosong (akan selalu kosong jika pertama kali di run appnya), maka
        DbHelper.instances.tbDailyFoodTransaction.insertMultipleData(_createDefaultData()) //bikin data default, hanya sekali setelah aplikasi diinstall atau datanya di clear
        .then((value) => _getData());
        print("you only see this once");
      } else {
        return value;
      }
    })
    .then((value) {    
      postTask = value!;
    });
  }

  List<FoodDailyModel> _createDefaultData() {
    return List.filled(DAY_IN_A_WEEK, FoodDailyModel() );
  }
}