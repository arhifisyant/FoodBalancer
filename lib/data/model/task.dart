
enum FoodType {
  MAIN_FOOD,
  SIDE_DISH,
  VEGETABLE,
  FRUIT
}

class TaskData {
  final int? id;
  final String? title;
  final FoodType? type;
  TaskData({this.id, this.title, this.type});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'type': type!.toString()};
  }
}