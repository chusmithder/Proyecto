class UserModel {
  String idUser;
  String email;
  String physicalGoal;
  String activityLevel;
  String gender;
  int birthYear;
  int height;
  double weight;
  List<String>? idsUserFood;
  List<String>? idsUserWeights;

  UserModel(
      {required this.idUser,
      required this.email,
      required this.gender,
      required this.birthYear,
      required this.weight,
      required this.height,
      required this.activityLevel,
      required this.physicalGoal,
      this.idsUserFood,
      this.idsUserWeights});

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "email": email,
        "gender": gender,
        "birthYear": birthYear,
        "weight": weight,
        "height": height,
        "activityLevel": activityLevel,
        "physicalGoal": physicalGoal,
        if (idsUserFood != null) "idsUserFood": idsUserFood,
        if (idsUserWeights != null) "idsUserWeights": idsUserWeights,
      };

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['idUser'],
      email: json['email'],
      gender: json['gender'],
      birthYear: json['birthYear'],
      weight: json['weight'],
      height: json['height'],
      activityLevel: json['activityLevel'],
      physicalGoal: json['physicalGoal'],
      idsUserFood: json['idsUserFood'] is Iterable
          ? List.from(json['idsUserFood'])
          : null,
      idsUserWeights: json['idsUserWeights'] is Iterable
          ? List.from(json['idsUserWeights'])
          : null,
    );
  }

  int getAge() {
    var x = {
      "idUser": "11111aaaaaa",
      "email": "1111@gmail.com",
      "gender": "MALE",
      "birthYear": 2000,
      "weight": 80,
      "height": 180,
      "activityLevel": "Very active",
      "physicalGoal": "Gain weight",
      "idsUserFood": ["aaaaaaaaaaaa", "bbbbbbbbbb"],
      "idsUserWeights": ["11111111111111", "2222222222222222"],
    };

    var y = {
      "id": "aaaaaaaaaaaa",
      "idUser": "11111aaaaaa",
      "description": "fries",
      "calories": 200,
      "carbs": 10,
      "proteins": 10,
      "fats": 10,
      "gramsPerServing": 100,
    };

    var z = {
      "idWeight": "11111111111111",
      "idUser": "11111aaaaaa",
      "date": "10/!0/2021",
      "weight": 80,
    };

    var m = 
    {
      "idFood": "asdasdisoiaj",
      "description": "oatmeal",
      "calories": 600,
      "carbs": 10,
      "proteins": 10,
      "fats": 10,
      "gramsPerServing": 100,
    };

    return DateTime.now().year - birthYear;
  }
}
