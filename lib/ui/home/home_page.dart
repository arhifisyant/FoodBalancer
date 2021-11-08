import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_balancer/ui/aboutus/about.dart';
import 'package:food_balancer/ui/foodcat/foot_category_page.dart';
import 'package:food_balancer/ui/foodstore/food_page.dart';
import 'package:food_balancer/ui/schedule/weekly_food_page.dart';
import 'package:food_balancer/ui/viewer/pdf_viewer.dart';
import 'package:get/get.dart';

enum SCREEN_TYPE {
  INPUT_MENU,
  DAILY_MENU,
  GUIDE,
  ABOUT
}

class MenuData{
  final Icon icon;
  final String label;
  final dynamic screenType;

  MenuData(this.icon, this.label, this.screenType);
}

class HomePage extends StatelessWidget {

  List<MenuData> _getData()=> [
    MenuData(const Icon(Icons.add_task_rounded), "Input Menu", SCREEN_TYPE.INPUT_MENU),
    MenuData(const Icon(Icons.timelapse_rounded), "Daily Menu", SCREEN_TYPE.DAILY_MENU),
    MenuData(const Icon(Icons.info_rounded), "Guideline", SCREEN_TYPE.GUIDE),
    MenuData(const Icon(Icons.person_rounded), "About Us", SCREEN_TYPE.ABOUT),
  ];

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Balancer"),
      ),
      body: ListView.builder(itemBuilder: (contex, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
          child: TextButton.icon(onPressed: (){
            switch (_getData()[index].screenType) {
              case SCREEN_TYPE.INPUT_MENU:
                Get.to(FoodCategoryPage());
                break;
              
              case SCREEN_TYPE.DAILY_MENU:
                Get.to(WeeklyFoodPage());
                break;

              case SCREEN_TYPE.GUIDE:
                Get.to(PdfGuideViewer());
                break;
              
              case SCREEN_TYPE.ABOUT:
                Get.to(AboutPage());
                break;
              default:
            }
          
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