import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Metodos generales para la aplicacion
class GeneralAppService {
  static void showMessage(
      String message, Color color, BuildContext buildContext) {
    ScaffoldMessenger.of(buildContext).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
      ),
    );
  }

  static Future<void> restartCompletedValues() async {
    //if son las 23:59 reiniciamos
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('completedCalories', 0);
    preferences.setDouble('completedCarbs', 0);
    preferences.setDouble('completedProteins', 0);
    preferences.setDouble('completedFats', 0);
  }
}
