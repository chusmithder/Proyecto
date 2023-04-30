import 'package:flutter/material.dart';
import 'package:revdiet/screens/3_signin_screen.dart';

void main(List<String> args) async {
  runApp(const RevDiet());
}

class RevDiet extends StatelessWidget {
  const RevDiet({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
