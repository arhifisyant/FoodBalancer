import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_balancer/ui/foodweekly/food_weekly_page.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: WeeklyFoodPage(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

