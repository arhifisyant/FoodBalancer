import 'package:food_balancer/data/db/db_helper.dart';
import 'package:food_balancer/data/model/daily_food.dart';
import 'package:food_balancer/data/model/task.dart';
import 'package:food_balancer/ui/foodstore/food_store_controller.dart';
import 'package:food_balancer/ui/foodweekly/food_weekly_controller.dart';
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

  _changeDataIfNull(DailyFoodModel data) {
    return DailyFoodModel(id: data.id, mainFood: data.mainFood??"-", sideDish: data.sideDish??"-", vegitable: data.vegitable??"-", fruit: data.fruit??"-");
  }

  updateCurrentData() async {
    var res = await DatabaseHelper.instances.dbDailyFoodTransaction.update(_changeDataIfNull(getTaskWekData))
    .then((value) => _taskController.onInit())
    .then((value) => Get.back());
    return res;
  }

  _getAllData() {
    DatabaseHelper.instances.dbMainFoodTransaction.queryAll()
    .then((value) {
      print("value is $value");
      postTask = value.map((e) => TaskData(id:e['id'],title: e['title'], type: FoodController.getEnumTypeBasedof(e['type']))).toList();
    });
  }
}