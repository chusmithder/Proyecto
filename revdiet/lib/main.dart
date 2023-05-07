import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/screens/1_auth_page.dart';
import 'package:revdiet/screens/3_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:revdiet/screens/4_signup_screen.dart';
import 'package:revdiet/screens/5_1_home_screen.dart';
import 'package:revdiet/screens/5_0_home_page.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
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
      home: HomePage()
    );
  }
}
