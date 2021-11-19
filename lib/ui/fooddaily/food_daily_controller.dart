import 'package:food_balancer/data/db/db_helper.dart';
import 'package:food_balancer/data/model/daily_food_model.dart';
import 'package:food_balancer/data/model/food_model.dart';
import 'package:food_balancer/ui/foodeditor/food_editor_controller.dart';
import 'package:food_balancer/ui/foodweekly/food_weekly_controller.dart';
import 'package:get/get.dart';

class WeeklySettingsController extends GetxController {

  var task = List<FoodModel>.empty().obs;
  set postTask(data) => task.value = data;
  List<FoodModel> get getTask => task.value;

  var taskWekData = DailyFoodModel().obs;
  set postTaskWeekData(data) => taskWekData.value = data;
  DailyFoodModel get getTaskWekData => taskWekData.value;

  final _taskController = Get.put(WeeklyFoodController());


  @override
  void onInit() {
    _getAllData();
    super.onInit();
  }

  udpateData({
    String? mainFood = null,
    String? sideDish = null,
    String? vegetable = null,
    String? fruit = null
  }) {
    taskWekData.value = getTaskWekData.copyWith(mainFood: mainFood, sideDish: sideDish, vegetable: vegetable, fruit: fruit);
  }

  _changeDataIfNull(DailyFoodModel data) {
    return DailyFoodModel(id: data.id, mainFood: data.mainFood??"-", sideDish: data.sideDish??"-", vegetable: data.vegetable??"-", fruit: data.fruit??"-");
  }

  updateCurrentData() async {
    var res = await DbHelper.instances.tbDailyFoodTransaction.update(_changeDataIfNull(getTaskWekData))
    .then((value) => _taskController.onInit())
    .then((value) => Get.back());
    return res;
  }

  _getAllData() {
    DbHelper.instances.tbFoodTransaction.queryAll()
    .then((value) {
      print("value is $value");
      postTask = value.map((e) => FoodModel(id:e['id'],title: e['title'], type: FoodController.getEnumTypeBasedof(e['type']))).toList();
    });
  }
}