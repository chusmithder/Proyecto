import 'package:flutter/material.dart';
import 'package:revdiet/screens/3_login_screen.dart';
import 'package:revdiet/screens/4_signup_screen.dart';

class LoginOrSignUpScreen extends StatefulWidget {
  const LoginOrSignUpScreen({super.key});

  @override
  State<LoginOrSignUpScreen> createState() => _LoginOrSignUpScreenState();
}

class _LoginOrSignUpScreenState extends State<LoginOrSignUpScreen> {
  //intially show the login screen
  bool showLoginScreen = true;

  //toggle between login and signup screen
  void _toogleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LogInScreen(
        onTap: _toogleScreens,
      );
    } else {
      return SignUpScreen(
        onTap: _toogleScreens,
      );
    }
  }
}
