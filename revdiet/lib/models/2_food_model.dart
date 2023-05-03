class FoodModel {
  int? id;
  String description;
  int calories; //kcal
  double carbs; //g
  double proteins;
  double fats;
  double gramsPerServing;

  FoodModel({
    this.id,
    required this.description,
    required this.calories,
    required this.carbs,
    required this.proteins,
    required this.fats,
    required this.gramsPerServing
  });
}