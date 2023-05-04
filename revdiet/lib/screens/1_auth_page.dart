import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/screens/2_login_or_signup_page.dart';
import 'package:revdiet/screens/3_login_screen.dart';
import 'package:revdiet/screens/5_home_page_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return HomePageScreen();
          }
          //user is not logged in
          else {
            return LoginOrSignUpScreen();
          }
        },
      ),
    );
  }
}