import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  String idUser;
  String email;
  String physicalGoal;
  String activityLevel;
  String gender;
  int birthYear;
  int height;
  double weight;

  UserModel({
    required this.idUser,
    required this.email,
    required this.gender,
    required this.birthYear,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.physicalGoal,
  });

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "email": email,
        "gender": gender,
        "birthYear": birthYear,
        "weight": weight,
        "height": height,
        "activityLevel": activityLevel,
        "physicalGoal": physicalGoal,
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
    );
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      idUser: data?['idUser'],
      email: data?['email'],
      gender: data?['gender'],
      birthYear: data?['birthYear'],
      weight: data?['weight'],
      height: data?['height'],
      activityLevel: data?['activityLevel'],
      physicalGoal: data?['physicalGoal'],
    );
  }
}
