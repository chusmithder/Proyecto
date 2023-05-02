import 'package:flutter/material.dart';
import 'package:revdiet/screens/3_login_screen.dart';
import 'package:revdiet/screens/4_signup_screen.dart';

void main(List<String> args) async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}
