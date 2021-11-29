import 'package:food_balancer/data/model/food_daily_model.dart';
import 'package:food_balancer/data/model/food_model.dart';
import 'package:food_balancer/ui/fooddaily/food_daily_controller.dart';
import 'package:food_balancer/ui/foodeditor/food_editor_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodDailyPage extends StatelessWidget {

  late FoodDailyController _weeklySettingsController;

  _cleanData(FoodDailyModel data) {
    return FoodDailyModel(
      id: data.id,
      mainFood: data.mainFood!.contains("-")?null:data.mainFood,
      sideDish: data.sideDish!.contains("-")?null:data.sideDish,
      vegetable: data.vegetable!.contains("-")?null:data.vegetable,
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
      if(data.where((element) => element.type== FoodType.VEGETABLE).map((e) => e.title).contains(foodData.vegetable)) {
        return foodData.vegetable;
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
    _descTxtStyle() => TextStyle(fontSize: 16, color: Colors.black,);
    _weeklySettingsController = Get.put(FoodDailyController());
    _weeklySettingsController.postTaskWeekData = _cleanData(Get.arguments[0]);

    return Scaffold(
      appBar: AppBar(title: Text("Pilih Menu Hari "+Get.arguments[1].toString()),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            _weeklySettingsController.updateCurrentData();
        },
        child: const Icon(Icons.save)
        ),
      body: Container(
      child: Obx(() => Column(
        children: [    
           ListTile(
               leading: Text("Pokok :", style: _descTxtStyle()),
               subtitle: DropdownButton(
                  isExpanded: true,
                  //itemHeight: 200.0,
                  //itemHeight: null,
                  value: _updateDataIfNull(FoodType.MAIN_FOOD),
                  onChanged: (String? value){
                    _weeklySettingsController.udpateData(mainFood: value);
                  },
                  items: _weeklySettingsController.getTask
                  .where((element) => element.type== FoodType.MAIN_FOOD)
                  .map((e) {
                  return DropdownMenuItem(child: Text(e.title!), value: e.title,);
                  }).toList()),
               trailing: IconButton(
                   onPressed: (){Get.to(() => FoodEditorPage(), arguments: [SCREEN_CAT_TYPE.MAINFOOD, "Makanan Pokok"]);},
                   icon: Icon(Icons.edit),
               ),
           ),


          ListTile(
            leading: Text("Lauk    :", style: _descTxtStyle()),
            subtitle: DropdownButton(
                isExpanded: true,
                value: _updateDataIfNull(FoodType.SIDE_DISH),
                onChanged: (String? value){
                  _weeklySettingsController.udpateData(sideDish: value);
                },
                items: _weeklySettingsController.getTask
                .where((element) => element.type== FoodType.SIDE_DISH)
                .map((e) {
                return DropdownMenuItem(child: Text(e.title!), value: e.title,);
              }).toList()),
            trailing: IconButton(
              onPressed: (){Get.to(() => FoodEditorPage(), arguments: [SCREEN_CAT_TYPE.SIDEDISH, "Lauk"]);},
              icon: Icon(Icons.edit),
            ),
          ),

          
         ListTile(
           leading: Text("Sayur   :", style: _descTxtStyle()),
           subtitle: DropdownButton(
            isExpanded: true,
            value: _updateDataIfNull(FoodType.VEGETABLE),           
            onChanged: (String? value){              
              _weeklySettingsController.udpateData(vegetable: value);
            },
            items: _weeklySettingsController.getTask
            .where((element) => element.type== FoodType.VEGETABLE)
            .map((e) {
            return DropdownMenuItem(child: Text(e.title!), value: e.title,);
          }).toList()),
           trailing: IconButton(
             onPressed: (){Get.to(() => FoodEditorPage(), arguments: [SCREEN_CAT_TYPE.VEGETABLE, "Sayur"]);},
             icon: Icon(Icons.edit),
           ),
         ),

         ListTile(
           leading: Text("Buah    :", style: _descTxtStyle()),
           subtitle: DropdownButton(
                isExpanded: true,
                value: _updateDataIfNull(FoodType.FRUIT),
                onChanged: (String? value){
                  _weeklySettingsController.udpateData(fruit: value);
                },
                items: _weeklySettingsController.getTask
                .where((element) => element.type== FoodType.FRUIT)
                .map((e) {
                return DropdownMenuItem(child: Text(e.title!), value: e.title,);
              }).toList()),
           trailing: IconButton(
             onPressed: (){Get.to(() => FoodEditorPage(), arguments: [SCREEN_CAT_TYPE.FRUIT, "Buah"]);},
             icon: Icon(Icons.edit),
           ),
         ),
        ],
      )),
    )
    );
  }
}

enum SCREEN_CAT_TYPE {
  MAINFOOD,
  SIDEDISH,
  VEGETABLE,
  FRUIT
}