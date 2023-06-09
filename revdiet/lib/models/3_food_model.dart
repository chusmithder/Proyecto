class FoodModel {
  // String idFood;
  String description;
  int calories; //kcal
  double carbs; //g
  double proteins; //g
  double fats;//g
  double gramsPerServing;//g

  FoodModel({
    // required this.idFood,
    required this.description,
    required this.calories,
    required this.carbs,
    required this.proteins,
    required this.fats,
    required this.gramsPerServing
  });

  Map<String, dynamic> toJson() => {
        // "idFood": idFood,
        "description": description,
        "calories": calories,
        "carbs": carbs,
        "proteins": proteins,
        "fats": fats,
        "gramsPerServing": gramsPerServing,
      };

  static FoodModel fromJson(Map<String, dynamic> json) {
    return FoodModel(
      // idFood: json['idFood'],
      description: json['description'],
      calories: json['calories'],
      carbs: json['carbs'],
      proteins: json['proteins'],
      fats: json['fats'],
      gramsPerServing: json['gramsPerServing'],
    );
  }
}