import 'package:flutter/material.dart';
import 'package:food_balancer/data/model/task.dart';
import 'package:food_balancer/ui/foodcat/foot_category_page.dart';
import 'package:food_balancer/ui/foodstore/food_store_controller.dart';
import 'package:get/get.dart';

class FoodPage extends StatelessWidget {
  late FoodController _taskController;

  _showInputDialog(BuildContext context, String title, TaskData taskData) {
    return showDialog(context: context, 
    builder: (BuildContext context) =>
      AlertDialog(
        title: Text(title),
        content: Container(
          child: TextFormField(
            controller: _taskController.addTaskController,
            decoration: InputDecoration(hintText: "Enter data"),
          ),
        ),
        actions: [
          TextButton.icon(onPressed: (){
            if(title=="Tambah"){
              _taskController.addData();
            } else {
              _taskController.updateData(taskData);
            }
          }, icon: Icon(title=="Tambah"?Icons.add:Icons.delete), label: Text(title))
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    _taskController  = Get.put(FoodController(screenType: Get.arguments));
    return Scaffold(
      appBar: AppBar(title: Text("List")),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showInputDialog(context, "Tambah", TaskData(id:0));
      },
      child: const Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: _taskController.addTaskController,
                  decoration: InputDecoration(hintText: "Enter data"),
                )),
                IconButton(onPressed: (){
                  _taskController.addData();
                }, icon: Icon(Icons.add))
              ],
            ),        
            Expanded(child: Obx(() => ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: Text(_taskController.getTask[index].title??""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()=> _showInputDialog(context, "Update Data", _taskController.getTask[index]), icon: Icon(Icons.update)),
                    IconButton(onPressed: ()=> _taskController.deleteTask(_taskController.getTask[index].id), icon: Icon(Icons.delete))
                  ],
                ),
              ),
              itemCount: _taskController.getTask.length,
              )))
          ],
        )
      ),
    );
  }
}