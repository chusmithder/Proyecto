//dtUsersFood
class UserFoodModel {
  // String idFood;
  String idUser;
  String description;
  int calories; //kcal
  double carbs; //g
  double proteins; //g
  double fats;//g
  double gramsPerServing;//g

  UserFoodModel({
    // required this.idFood,
    required this.idUser,
    required this.description,
    required this.calories,
    required this.carbs,
    required this.proteins,
    required this.fats,
    required this.gramsPerServing
  });

  Map<String, dynamic> toJson() => {
        // "idFood": idFood,
        "idUser": idUser,
        "description": description,
        "calories": calories,
        "carbs": carbs,
        "proteins": proteins,
        "fats": fats,
        "gramsPerServing": gramsPerServing,
      };

  static UserFoodModel fromJson(Map<String, dynamic> json) {
    return UserFoodModel(
      // idFood: json['idFood'],
      idUser: json['idUser'],
      description: json['description'],
      calories: json['calories'],
      carbs: json['carbs'],
      proteins: json['proteins'],
      fats: json['fats'],
      gramsPerServing: json['gramsPerServing'],
    );
  }
}