import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/enums/activity_levels.dart';
import 'package:revdiet/enums/genders_enum.dart';
import 'package:revdiet/enums/physical_goals_enum.dart';
import 'package:revdiet/models/2_user_model.dart';
import 'package:revdiet/screens/5_1_home_screen.dart';
import 'package:revdiet/screens/5_2_scale_screen.dart';
import 'package:revdiet/screens/5_3_user_screen.dart';
import 'package:revdiet/services/1_logical_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});


  //calorias del usuario

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  final List<Widget> _screens = <Widget>[
    HomeScreen(),
    ScaleScreen(),
    UserScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 51, 51, 51)),
      backgroundColor: const Color.fromARGB(255, 51, 51, 51),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scale),
            label: 'Scale',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 66, 204, 137),
        onTap: _onItemTapped,
      ),
    );
  }
}
