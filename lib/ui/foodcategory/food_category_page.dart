import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_balancer/ui/foodeditor/food_editor_page.dart';
import 'package:get/get.dart';

enum SCREEN_CAT_TYPE {
  MAINFOOD,
  SIDEFOOD,
  VEGETABLE,
  FRUIT
}

class MenuData{
  final Icon icon;
  final String label;
  final dynamic screenType;
  MenuData(this.icon, this.label, this.screenType);
}

class FoodCategoryPage extends StatelessWidget {

  List<MenuData> _getData()=> [
    MenuData(const Icon(Icons.add_task_rounded), "Makanan Pokok", SCREEN_CAT_TYPE.MAINFOOD),
    MenuData(const Icon(Icons.add_task_rounded), "Lauk", SCREEN_CAT_TYPE.SIDEFOOD),
    MenuData(const Icon(Icons.add_task_rounded), "Sayur", SCREEN_CAT_TYPE.VEGETABLE),
    MenuData(const Icon(Icons.add_task_rounded), "Buah", SCREEN_CAT_TYPE.FRUIT),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Atur Makanan"),
        ),
        body: ListView.builder(itemBuilder: (contex, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
            child: TextButton.icon(onPressed: (){
              final cat = _getData()[index].screenType;
              print("category is $cat");
              //Get.to(FoodEditorPage(),arguments: cat);
              Get.to(() => FoodEditorPage(),arguments: cat);
            }, icon: _getData()[index].icon, label: Text(_getData()[index].label),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFF2A8068)),
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        )
                    )
                )),
          );
        },
          itemCount: _getData().length,)
    );
  }
}