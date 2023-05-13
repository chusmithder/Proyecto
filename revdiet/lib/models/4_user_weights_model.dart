//dtUsersWeights
import 'package:cloud_firestore/cloud_firestore.dart';

class UserWeightsModel {
  // String idFood;
  String idUser;
  Timestamp date;
  double weight;

  UserWeightsModel({
    // required this.idFood,
    required this.idUser,
    required this.date,
    required this.weight,
  });

  Map<String, dynamic> toJson() => {
        // "idFood": idFood,
        "idUser": idUser,
        "date": date,
        "weight": weight,
      };

  static UserWeightsModel fromJson(Map<String, dynamic> json) {
    return UserWeightsModel(
      // idFood: json['idFood'],
      idUser: json['idUser'],
      date: json['date'],
      weight: json['weight'],
    );
  }
}
