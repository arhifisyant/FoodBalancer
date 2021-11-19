class DailyFoodModel {
  final int? id;
  final String? mainFood;
  final String? sideDish;
  final String? vegetable;
  final String? fruit;

  DailyFoodModel({this.id, this.mainFood = "-", this.sideDish = "-", this.vegetable = "-", this.fruit = "-"});
  Map<String, dynamic> toMap() => 
  {
    'id': id,
    'mainFood' : mainFood,
    'sideDish' : sideDish,
    'vegetable' : vegetable,
    'fruit': fruit
  };

  DailyFoodModel copyWith({
    int? id = null,
    String? mainFood = null,
    String? sideDish = null,
    String? vegetable = null,
    String? fruit = null
  }) {
    return DailyFoodModel(
      id: id ?? this.id,
      mainFood: mainFood ?? this.mainFood,
      sideDish: sideDish ?? this.sideDish,
      vegetable: vegetable ?? this.vegetable,
      fruit: fruit ?? this.fruit
    );
  }
}