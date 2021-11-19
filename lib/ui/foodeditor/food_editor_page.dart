import 'package:food_balancer/data/model/food_model.dart';
import 'package:food_balancer/ui/foodeditor/food_editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodEditorPage extends StatelessWidget {
  late FoodController _taskController;

  @override
  Widget build(BuildContext context) {
    _taskController  = Get.put(FoodController(screenType: Get.arguments));
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Makanan")),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextFormField(
                  maxLength: 20,
                  controller: _taskController.addTaskController,
                  decoration: InputDecoration(hintText: "Masukkan Data"),
                )),
                IconButton(onPressed: (){
                  _taskController.addData();
                }, icon: Icon(Icons.add))
              ],
            ),
            Expanded(child: Obx(() => ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: Text(_taskController.getTask[index].title??""), // ini bikin list makanannya
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()=> _showEditDialog(context, "Edit", _taskController.getTask[index]), icon: Icon(Icons.edit)),
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

  _showEditDialog(BuildContext context, String title, FoodModel taskData) {
    return showDialog(context: context,
        builder: (BuildContext builderContext) =>
            AlertDialog(
              title: Text(title),
              content: Container(
                child: TextFormField(
                  controller: _taskController.addTaskController..text = title=="Tambah"? "":taskData.title??"",
                  decoration: InputDecoration(hintText: "Edit Makanan"),
                  maxLength: 20,
                ),
              ),
              actions: [
                TextButton.icon(onPressed: (){
                  _taskController.updateData(taskData);
                  Navigator.pop(builderContext);
                }, icon: Icon(Icons.save), label: Text('Save'))
              ],
            )
    );
  }

}