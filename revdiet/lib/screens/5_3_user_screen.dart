import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

void _logout() {
    FirebaseAuth.instance.signOut();
  }
class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const[
          const Text('profile screen'),
          CustomButton(onTap: _logout, buttonText: 'SIGN OUT')
        ],
      ),
    );
  }
}
