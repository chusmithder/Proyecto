import 'package:flutter/material.dart';
import 'package:revdiet/screens/5_1_home_screen.dart';
import 'package:revdiet/screens/5_2_weights_screen.dart';
import 'package:revdiet/screens/5_4_user_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    const ScaleScreen(),
    const UserScreen()
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
