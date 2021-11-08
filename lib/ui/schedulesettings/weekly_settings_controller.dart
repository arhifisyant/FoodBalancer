import 'package:food_balancer/data/db/db_helper.dart';
import 'package:food_balancer/data/model/daily_food.dart';
import 'package:food_balancer/data/model/task.dart';
import 'package:food_balancer/ui/foodstore/food_store_controller.dart';
import 'package:food_balancer/ui/schedule/weekly_food_controller.dart';
import 'package:get/get.dart';

class WeeklySettingsController extends GetxController {

  var task = List<TaskData>.empty().obs;
  set postTask(data) => task.value = data;
  List<TaskData> get getTask => task.value;

  var taskWekData = DailyFoodModel().obs;
  set postTaskWeekData(data) => taskWekData.value = data;
  DailyFoodModel get getTaskWekData => taskWekData.value;

  final _taskController = Get.put(WeeklyFoodControlelr());


  @override
  void onInit() {
    _getAllData();
    super.onInit();
  }

  udpateData({
     String? mainFood = null,
   String? sideDish = null,
   String? vegitable = null,
   String? fruit = null
  }) {
    taskWekData.value = getTaskWekData.copyWith(mainFood: mainFood, sideDish: sideDish, vegitable: vegitable, fruit: fruit);
  }

  updateCurrentData() async {
    var res = await DatabaseHelper.instances.dbDailyFoodTransaction.update(getTaskWekData)
    .then((value) => _taskController.onInit())
    .then((value) => Get.back());
    return res;
  }

  _getAllData() {
    DatabaseHelper.instances.dbMainFoodTransacktion.queryAll()
    .then((value) {
      print("value is $value");
      postTask = value.map((e) => TaskData(id:e['id'],title: e['title'], type: FoodController.getEnumTypeBasedof(e['type']))).toList();
    });
  }
}