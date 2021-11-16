import 'package:flutter/material.dart';
import 'package:food_balancer/ui/foodcat/foot_category_page.dart';
import 'package:food_balancer/ui/foodstore/food_page.dart';
import 'package:food_balancer/ui/home/home_page.dart';
import 'package:food_balancer/ui/schedule/weekly_food_page.dart';
import 'package:food_balancer/ui/schedulesettings/weekly_settings_page.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
e      //home: WeeklyFoodPage(),
    );
  }
}