import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_balancer/ui/foodweekly/food_weekly_page.dart';

void main(List<String> args) {
  runApp(
      GetMaterialApp(
        home: WeeklyFoodPage(),
        theme: ThemeData(primarySwatch: Colors.green),
      )
  );
}