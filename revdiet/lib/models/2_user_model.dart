import 'package:flutter/foundation.dart';

class UserModel {
  late int desiredWeight;

  int? id;
  String username;
  String email;
  String password;
  String physicalGoal;
  String activityLevel;
  String gender;
  DateTime birthDate;
  double height;
  double weight;
  String residenceCountry;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.physicalGoal,
    required this.residenceCountry,
  });
}
