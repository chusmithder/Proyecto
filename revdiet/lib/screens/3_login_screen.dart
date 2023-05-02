import 'package:flutter/material.dart';
import 'package:revdiet/components/1_custom_text_field.dart';
import 'package:revdiet/components/2_custom_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LogInScreenState();
  }
}

class LogInScreenState extends State<StatefulWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _signInUser() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Incorrect data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
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
                const Text('Hello',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const Text('Sign in into your account',
                    style: TextStyle(fontSize: 20, color: Colors.grey)),
                const SizedBox(height: 50),

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

                const SizedBox(height: 30),
                //sign in button
                CustomButton(
                  onTap: _signInUser,
                  buttonText: 'Log in',
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
