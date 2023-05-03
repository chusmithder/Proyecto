import 'package:flutter/foundation.dart';

class UserModel {
  late int desiredWeight;

  int? id;
  String firstName;
  String lastName;
  String email;
  String password;
  String gender;
  DateTime birthDate;
  double weight;
  double height;
  String activityLevel;
  String physicalGoal;
  String residenceCountry;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
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
