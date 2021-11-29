import 'package:food_balancer/data/db/db_helper.dart';
import 'package:food_balancer/data/model/food_daily_model.dart';
import 'package:food_balancer/data/model/food_model.dart';
import 'package:food_balancer/ui/fooddaily/food_daily_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodEditorController extends GetxController {

  var task = List<FoodModel>.empty().obs;
  set postTask(data) => task.value = data;
  List<FoodModel> get getTask => task.value;

  var taskDaily = List<FoodDailyModel>.empty().obs;
  set postTaskDaily(data) => taskDaily.value = data;
  List<FoodDailyModel> get getTaskDaily => taskDaily.value;

  late FoodType category;
  late TextEditingController addTaskController;
  late TextEditingController updateTaskController;

  FoodEditorController({required SCREEN_CAT_TYPE screenType}) {
    switch (screenType) {
      case SCREEN_CAT_TYPE.MAINFOOD:
        category = FoodType.MAIN_FOOD;
        break;
      case SCREEN_CAT_TYPE.SIDEDISH:
        category = FoodType.SIDE_DISH;
        break;
      case SCREEN_CAT_TYPE.VEGETABLE:
        category = FoodType.VEGETABLE;
        break;
      case SCREEN_CAT_TYPE.FRUIT:
        category = FoodType.FRUIT;
        break;
    }
  }

  @override
  void onInit() {
    addTaskController = TextEditingController();
    updateTaskController = TextEditingController();
    _getData();
    _getDataDaily();
    super.onInit();
  }

  _getData(){
    task.clear();
    DbHelper.instances.tbFoodTransaction.queryAllbased(category.toString()).then((value) {
      postTask = value.map((e) => FoodModel(id:e['id'],title: e['title'], type: getEnumTypeBasedof(e['type']))).toList().reversed.toList();
      getTask.forEach((element) {
        print(element.title);
      });
    }
    );
  }

  _getDataDaily(){
    taskDaily.clear();
    DbHelper.instances.tbFoodDailyTransaction.queryAll().then((value) {
      postTaskDaily = value.map((e) => FoodDailyModel(id:e['id'], mainFood: e['mainFood'], sideDish: e['sideDish'], vegetable: e['vegetable'],  fruit: e['fruit'], )).toList().reversed.toList();
      getTaskDaily.forEach((element) {
        print(element.mainFood);
        print(element.sideDish);
        print(element.vegetable);
        print(element.fruit);
      });
    }
    );
  }

  static getEnumTypeBasedof(String value) {
    if(value.contains(FoodType.MAIN_FOOD.toString())) {
      return FoodType.MAIN_FOOD;
    } else if(value.contains(FoodType.SIDE_DISH.toString())) {
      return FoodType.SIDE_DISH;
    } else if(value.contains(FoodType.VEGETABLE.toString())) {
      return FoodType.VEGETABLE;
    } else if(value.contains(FoodType.FRUIT.toString())) {
      return FoodType.FRUIT;
    }
  }

  addData() async {
    if(getTask.map((e) => e.title).contains(addTaskController.text)) {
      Get.snackbar("Peringatan", "Data Sudah Tersedia");
    } else if(false) {
      Get.snackbar("Peringatan", "Data Tidak Boleh Kosong");
    } else {
      final tempData = FoodModel(title: addTaskController.text, type: category);
      await DbHelper.instances.tbFoodTransaction.insert(tempData);
      _getData();
    }
    addTaskController.clear();
  }

  updateData(FoodModel data) {
    final tempData = FoodModel(id:data.id, title: updateTaskController.text, type: data.type);
    DbHelper.instances.tbFoodTransaction.update(tempData).then((value) {
    var index = task.indexWhere((element) => element.id == data.id);
    getTask[index] = tempData;
    //var test = <TaskData>[]..addAll(getTask);
    // postTask = test;
    task[index] = tempData;
    getTask.forEach((element) {
      print(element.title);
    });
    }
    );
    updateTaskController.clear();
  }

  updateDataDaily(FoodDailyModel data) {
    final tempData = FoodDailyModel(id:data.id, mainFood: data.mainFood, sideDish: data.sideDish, vegetable: data.vegetable, fruit: data.fruit);
    DbHelper.instances.tbFoodDailyTransaction.update(tempData).then((value) {
      var index = task.indexWhere((element) => element.id == data.id);
      getTaskDaily[index] = tempData;
      //var test = <TaskData>[]..addAll(getTask);
      // postTask = test;
      taskDaily[index] = tempData;
      getTaskDaily.forEach((element) {
        print(element.id);
      });
    }
    );
    updateTaskController.clear();
  }

  deleteTask(int? id) async {
    if(id != null) {
      await DbHelper.instances.tbFoodTransaction.delete(id);
      task.removeWhere((element) => element.id == id);
    }
    
  }
}