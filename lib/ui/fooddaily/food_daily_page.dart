import 'package:flutter/material.dart';
import 'package:food_balancer/data/model/daily_food.dart';
import 'package:food_balancer/data/model/task.dart';
import 'package:food_balancer/ui/fooddaily/food_daily_controller.dart';
import 'package:get/get.dart';

class WeeklySettingsPage extends StatelessWidget {

  late WeeklySettingsController _weeklySettingsController;

  _cleanData(DailyFoodModel data) {
    return DailyFoodModel(
      id: data.id,
      mainFood: data.mainFood!.contains("-")?null:data.mainFood,
      sideDish: data.sideDish!.contains("-")?null:data.sideDish,
      vegitable: data.vegitable!.contains("-")?null:data.vegitable,
      fruit: data.fruit!.contains("-")?null:data.fruit,
      );
  }

  String? _updateDataIfNull(FoodType type) {
    final data = _weeklySettingsController.getTask;
    final foodData = _weeklySettingsController.getTaskWekData;
    
    if(type == FoodType.MAIN_FOOD) {
      if(data.where((element) => element.type== FoodType.MAIN_FOOD).map((e) => e.title).contains(foodData.mainFood)) {
        return foodData.mainFood;
      } else {
        return null;
      }
    } else if(type == FoodType.SIDE_DISH) {
      if(data.where((element) => element.type== FoodType.SIDE_DISH).map((e) => e.title).contains(foodData.sideDish)) {
        return foodData.sideDish;
      } else {
        return null;
      }
    } else if(type == FoodType.VEGETABLE) {
      if(data.where((element) => element.type== FoodType.VEGETABLE).map((e) => e.title).contains(foodData.vegitable)) {
        return foodData.vegitable;
      } else {
        return null;
      }
    } else if(type == FoodType.FRUIT) {
      if(data.where((element) => element.type== FoodType.FRUIT).map((e) => e.title).contains(foodData.fruit)) {
        return foodData.fruit;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _weeklySettingsController = Get.put(WeeklySettingsController());
    _weeklySettingsController.postTaskWeekData = _cleanData(Get.arguments);

    return Scaffold(
      appBar: AppBar(title: Text("Menu Harian"),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            _weeklySettingsController.updateCurrentData();
        },
        child: const Icon(Icons.save),
        ),
      body: Container(
      child: Obx(() => Column(
        children: [    
           ListTile(leading: Text("Pokok :"), trailing: DropdownButton(
            value: _updateDataIfNull(FoodType.MAIN_FOOD),           
            onChanged: (String? value){              
              _weeklySettingsController.udpateData(mainFood: value);
            },
            items: _weeklySettingsController.getTask
          .where((element) => element.type== FoodType.MAIN_FOOD)
          .map((e) {            
            return DropdownMenuItem(child: Text(e.title!), value: e.title,);
          }).toList()),),
          

          ListTile(leading: Text("Lauk    :"), trailing: DropdownButton(
            value: _updateDataIfNull(FoodType.SIDE_DISH),           
            onChanged: (String? value){              
              _weeklySettingsController.udpateData(sideDish: value);
            },
            items: _weeklySettingsController.getTask
          .where((element) => element.type== FoodType.SIDE_DISH)
          .map((e) {            
            return DropdownMenuItem(child: Text(e.title!), value: e.title,);
          }).toList()),),

          
         ListTile(leading: Text("Sayur   :"), trailing: DropdownButton(
            value: _updateDataIfNull(FoodType.VEGETABLE),           
            onChanged: (String? value){              
              _weeklySettingsController.udpateData(vegitable: value);
            },
            items: _weeklySettingsController.getTask
          .where((element) => element.type== FoodType.VEGETABLE)
          .map((e) {            
            return DropdownMenuItem(child: Text(e.title!), value: e.title,);
          }).toList()),),

         ListTile(leading: Text("Buah    :"), trailing: DropdownButton(
            value: _updateDataIfNull(FoodType.FRUIT),           
            onChanged: (String? value){              
              _weeklySettingsController.udpateData(fruit: value);
            },
            items: _weeklySettingsController.getTask
          .where((element) => element.type== FoodType.FRUIT)
          .map((e) {            
            return DropdownMenuItem(child: Text(e.title!), value: e.title,);
          }).toList()),),
        ],
      )),
    )
    );
  }
}