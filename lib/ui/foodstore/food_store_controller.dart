import 'package:flutter/material.dart';
import 'package:food_balancer/data/db/db_helper.dart';
import 'package:food_balancer/data/model/task.dart';
import 'package:food_balancer/ui/foodcat/foot_category_page.dart';
import 'package:get/get.dart';


class FoodController extends GetxController {

  var task = List<TaskData>.empty().obs;
  set postTask(data) => task.value = data;
  List<TaskData> get getTask => task.value;

  late FoodType category;
  late TextEditingController addTaskController;

  FoodController({required SCREEN_CAT_TYPE screenType}) {
    switch (screenType) {
      case SCREEN_CAT_TYPE.MAINFOOD:
        category = FoodType.MAIN_FOOD;
        break;
      case SCREEN_CAT_TYPE.SIDEFOOD:
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
  _getData();
    super.onInit();
  }

  _getData(){
    task.clear();
    DatabaseHelper.instances.dbMainFoodTransacktion.queryAllbased(category.toString()).then((value) {
      postTask = value.map((e) => TaskData(id:e['id'],title: e['title'], type: getEnumTypeBasedof(e['type']))).toList().reversed.toList();
      // print("result posttask is ${value.map((e) => TaskData(id:e['id'],title: e['title'])).toList().}");
      getTask.forEach((element) {
        print(element.title);
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
    } else {
      final tempData = TaskData(title: addTaskController.text, type: category);
      await DatabaseHelper.instances.dbMainFoodTransacktion.insert(tempData);
      _getData();
    }
    
    addTaskController.clear();
  }

  updateData(TaskData data) {
    final tempData = TaskData(id:data.id, title: addTaskController.text, type: data.type);
    DatabaseHelper.instances.dbMainFoodTransacktion.update(tempData).then((value) {
    var index = task.indexWhere((element) => element.id == data.id);
    getTask[index] = tempData;
    var test = <TaskData>[]..addAll(getTask);
    // postTask = test;
    task[index] = tempData;
    getTask.forEach((element) {
      print(element.title);
    });
    }
    );
    
    addTaskController.clear();
  }

  deleteTask(int? id) async {
    if(id != null) {
      await DatabaseHelper.instances.dbMainFoodTransacktion.delete(id);
      task.removeWhere((element) => element.id == id);
    }
    
  }
}