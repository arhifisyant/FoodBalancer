import 'package:food_balancer/data/db/db_helper.dart';
import 'package:food_balancer/data/model/daily_food.dart';
import 'package:food_balancer/data/model/task.dart';
import 'package:get/get.dart';
//import 'package:sqflite/sqlite_api.dart';

class WeeklyFoodController extends GetxController {

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
    .then((value) => value.map((e) => DailyFoodModel(id: e['id'], mainFood: e['mainFood'], sideDish: e['sideDish'], vegetable: e['vegetable'], fruit: e['fruit'])).toList())
    .then((value) {
      if(value.isEmpty) { // jika hasil query kosong (akan selalu kosong jika pertama kali di run appnya), maka
        DatabaseHelper.instances.dbDailyFoodTransaction.insertMultipleData(_createDefaultData()) //bikin data default, hanya sekali setelah aplikasi diinstall atau datanya di clear
        .then((value) => _getData());
        final tempData = TaskData(title: "Nasi Putih", type: FoodType.MAIN_FOOD);
        DatabaseHelper.instances.dbMainFoodTransaction.insert(tempData);
        print("you only see this once");
      } else {
        return value;
      }
    })
    .then((value) {    
      postTask = value!;
    });
  }

  List<DailyFoodModel> _createDefaultData() {
    return List.filled(DAY_IN_A_WEEK, DailyFoodModel() );
  }
}