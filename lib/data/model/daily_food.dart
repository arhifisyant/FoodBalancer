class DailyFoodModel {
  final int? id;
  final String? mainFood;
  final String? sideDish;
  final String? vegitable;
  final String? fruit;

  DailyFoodModel({this.id, this.mainFood = "-", this.sideDish = "-", this.vegitable = "-", this.fruit = "-"});
  Map<String, dynamic> toMap() => 
  {
    'id': id,
    'mainFood' : mainFood,
    'sideDish' : sideDish,
    'vegetable' : vegitable,
    'fruit': fruit
  };

  DailyFoodModel copyWith({
    int? id = null,
     String? mainFood = null,
   String? sideDish = null,
   String? vegitable = null,
   String? fruit = null
  }) {
    return DailyFoodModel(
      id: id ?? this.id,
      mainFood: mainFood ?? this.mainFood,
      sideDish: sideDish ?? this.sideDish,
      vegitable: vegitable ?? this.vegitable,
      fruit: fruit ?? this.fruit
    );
  }
}