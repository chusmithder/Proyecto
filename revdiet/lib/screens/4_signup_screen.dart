import 'package:flutter/material.dart';
import 'package:revdiet/components/1_custom_text_field.dart';
import 'package:revdiet/components/2_custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<StatefulWidget> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  
  late String physicalGoal;
  late String activityLevel;
  late String gender;
  late int age;
  late String residenceCountry;
  late int height;//cm
  late int weight;
  late int desiredWeight;

  //username
  //email
  //contraseña
  //edad
  //peso
  //objetivo
  //nivel de actividad

  void _createAccount() {
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text('Welcome to RevDiet',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 10),
                const Text('Create an account',
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                const SizedBox(height: 50),

                //full name textfield
                CustomTextField(
                  controller: usernameController,
                  hintText: 'Full Name',
                  obscuredText: false,
                  icon: Icons.mail,
                ),

                //email textfield
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscuredText: false,
                  icon: Icons.mail,
                ),

                const SizedBox(height: 10),

                //password textfield
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscuredText: true,
                  icon: Icons.lock,
                ),

                //password confiramtion textfield
                CustomTextField(
                  controller: passwordConfirmationController,
                  hintText: 'Password confirmation',
                  obscuredText: true,
                  icon: Icons.lock,
                ),

                const SizedBox(height: 30),
                //sign in button
                CustomButton(
                  onTap: _createAccount,
                  buttonText: 'Create account',
                ),

                const SizedBox(height: 30),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}