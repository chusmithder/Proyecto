//dtUsersWeights
import 'package:cloud_firestore/cloud_firestore.dart';

class UserWeightsModel {
  // String idWeight;
  String idUser;
  Timestamp date;
  double weight;

  UserWeightsModel({
    // required this.idWeight,
    required this.idUser,
    required this.date,
    required this.weight,
  });

  Map<String, dynamic> toJson() => {
        // "idWeight": idWeight,
        "idUser": idUser,
        "date": date,
        "weight": weight,
      };

  static UserWeightsModel fromJson(Map<String, dynamic> json) {
    return UserWeightsModel(
      // idWeight: json['idWeight'],
      idUser: json['idUser'],
      date: json['date'],
      weight: json['weight'],
    );
  }
}
