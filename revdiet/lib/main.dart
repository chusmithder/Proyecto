import 'package:flutter/material.dart';
import 'package:revdiet/screens/1_auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> restartCompletedValues() async {
  if (DateTime.now().hour == DateTime(100).hour) {}
  //ver si la hora

  //if son las 23:59 reiniciamos
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('completedCalories', 0);
  preferences.setDouble('completedCarbs', 0);
  preferences.setDouble('completedProteins', 0);
  preferences.setDouble('completedFats', 0);
}

void main(List<String> args) async {
  await restartCompletedValues();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: const Color.fromARGB(255, 51, 51, 51),
        ),
        home: AuthPage());
  }
}