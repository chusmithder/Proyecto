import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/screens/2_login_or_signup_page.dart';
import 'package:revdiet/screens/5_0_home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  //metodo que espera 10 segundos mas para insertar un usario
  //en dtUsers despues de insertarlo en Authentication
  Stream<User?> methodStream() {
    Future.delayed(const Duration(seconds: 10));
    return FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: methodStream(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return HomePage();
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