import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/components/2_custom_button.dart';
import 'package:revdiet/models/2_user_model.dart';
import 'package:revdiet/services/0_general_app_service.dart';
import 'package:revdiet/services/2_database_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

void _logout() {
  FirebaseAuth.instance.signOut();
}

class _UserScreenState extends State<UserScreen> {
  //usuario actual
  UserModel? user;

  Future<void> _loadUser() async {
    try {
      String userId = await DatabaseService.getCurrentUserId();
      UserModel currentUser = await DatabaseService.getUserById(userId);
      setState(() {
        user = currentUser;
      });
    } on Exception catch (e) {
      GeneralAppService.showMessage(e.toString(), Colors.red, context);
    }
  }

  Future<void> _loadinitialData() async {
    await _loadUser();
  }

  @override
  void initState() {
    _loadinitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              _titleWidget(),
              const SizedBox(height: 25),
              _userDataWidget(),
              const SizedBox(height: 25),
              const CustomButton(onTap: _logout, buttonText: 'Log out')
            ],
          ),
        ),
      ),
    );
  }

  Widget _userDataWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 94, 94, 94),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'User data',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _propertyWidget('Email', user!.email),
            const SizedBox(height: 20),
            _propertyWidget('Gender', user!.gender),
            const SizedBox(height: 20),
            _propertyWidget('Age', user!.getAge().toString()),
            const SizedBox(height: 20),
            _propertyWidget('Weight', user!.weight.toString()),
            const SizedBox(height: 20),
            _propertyWidget('Height', user!.height.toString()),
            const SizedBox(height: 20),
            _propertyWidget('Physical Goal', user!.physicalGoal),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _propertyWidget(String title, String value) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '$title:',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 66, 204, 137)),
          ),
        ),
        const Expanded(child: const SizedBox()),
      ],
    );
  }

  Widget _titleWidget() {
    return GestureDetector(
      child: const Text('RevDiet',
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 66, 204, 137))),
    );
  }
}
