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

  _titleTxtStyle() => TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold,);
  _descTxtStyle() => TextStyle(fontSize: 16, color: Colors.white,);
  @override
  Widget build(BuildContext context) {
    _taskController = Get.put(WeeklyFoodControlelr());
    return Scaffold(
      appBar: AppBar(title: Text("Menu Seminggu"),
        centerTitle: true,),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          children: [
            Expanded(
                child: Obx(()=> GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20
                  ),
                  itemBuilder: (context, index) => Material(
                      color: Colors.green,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Get.to(WeeklySettingsPage(), arguments: _taskController.getTask[index]);
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2.0),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(_addDayofName()[index], style: _titleTxtStyle(),)),
                            //  Text("\n"),
                                SizedBox(height: 2.0),
                                Text("Pokok : " + _taskController.getTask[index].mainFood!, style: _descTxtStyle(),),
                                Text("Lauk : " + _taskController.getTask[index].sideDish!, style: _descTxtStyle()),
                                Text("Sayur : " + _taskController.getTask[index].vegitable!, style: _descTxtStyle()),
                                Text("Buah : " + _taskController.getTask[index].fruit!,style: _descTxtStyle())
                              ],
                            ),
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