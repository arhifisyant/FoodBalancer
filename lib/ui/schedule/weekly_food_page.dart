import 'package:flutter/material.dart';
import 'package:food_balancer/ui/schedule/weekly_food_controller.dart';
import 'package:food_balancer/ui/schedulesettings/weekly_settings_page.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WeeklyFoodPage extends StatelessWidget {

  late WeeklyFoodControlelr _taskController;

  _addDayofName() => [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu"
  ];

  _descTxtStyle() => TextStyle(fontSize: 14, color: Colors.white);
  _titleTxtStyle() => TextStyle(fontSize: 18, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    _taskController = Get.put(WeeklyFoodControlelr());
    return Scaffold(
      appBar: AppBar(title: Text("Weekly Basis"),),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Obx(()=> GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5                 
                ), 
                itemBuilder: (context, index) => Material(
                  color: Colors.green,
                  child: InkWell(
                  onTap: () {
                    Get.to(WeeklySettingsPage(), arguments: _taskController.getTask[index]);
                  },
                  child: Container(                                                
                  child: Column(                    
                    children: [
                      Text(_addDayofName()[index], style: _titleTxtStyle(),),
                      Text(_taskController.getTask[index].mainFood!, style: _descTxtStyle(),),
                      Text(_taskController.getTask[index].sideDish!, style: _descTxtStyle()),
                      Text(_taskController.getTask[index].vegitable!, style: _descTxtStyle()),
                      Text(_taskController.getTask[index].fruit!,style: _descTxtStyle())
                    ],
                  ),),
                )
                ),
                itemCount: _taskController.getTask.length,))
              )
          ],
        ),
      ),
    );
  }
}