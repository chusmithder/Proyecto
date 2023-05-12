import 'package:flutter/material.dart';
import 'package:revdiet/screens/1_auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void restartCompletedValues() {

}
void main(List<String> args) async {
  restartCompletedValues();
  
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
      home: AuthPage()
    );
  }
}
