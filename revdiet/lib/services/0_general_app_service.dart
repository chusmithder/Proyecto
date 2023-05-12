import 'package:flutter/material.dart';

//Metodos generales para la aplicacion
class GeneralAppService {

  static void showMessage(String message, Color color, BuildContext buildContext) {
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
}
