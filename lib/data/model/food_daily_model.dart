class FoodDailyModel {
  final int? id;
  final String? mainFood;
  final String? sideDish;
  final String? vegetable;
  final String? fruit;

  FoodDailyModel({this.id, this.mainFood, this.sideDish, this.vegetable, this.fruit});
  Map<String, dynamic> toMap() => 
  {
    'id': id,
    'mainFood' : mainFood,
    'sideDish' : sideDish,
    'vegetable' : vegetable,
    'fruit': fruit
  };

  FoodDailyModel copyWith({
    int? id = null,
    String? mainFood = null,
    String? sideDish = null,
    String? vegetable = null,
    String? fruit = null
  }) {
    return FoodDailyModel(
      id: id ?? this.id,
      mainFood: mainFood ?? this.mainFood,
      sideDish: sideDish ?? this.sideDish,
      vegetable: vegetable ?? this.vegetable,
      fruit: fruit ?? this.fruit
    );
  }
}