import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/screens/5_1_home_screen.dart';
import 'package:revdiet/screens/5_2_scale_screen.dart';
import 'package:revdiet/screens/5_3_user_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  // final user = FirebaseAuth.instance.currentUser!;

  //calorias totales

  

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  //calorias completadas
  

  @override
  void initState() {
    // _loadCurrentUser();
    super.initState();
  }

  Future<void> _loadCurrentUser() async {
    var db = FirebaseFirestore.instance;
    var usersAuth = db.collection('dtUsers');

    var users = await usersAuth.get();

    users.docs.forEach((doc) {
      print(doc.data());
    });

    // var user1 = usersAuth.doc('1');

    // user1.get().then(
    //   (DocumentSnapshot doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //     // ...
    //   },
    //   onError: (e) => print("Error getting document: $e"));
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
      appBar: AppBar(
          // title: Center(
          //     child: Text(
          //   'Hoy',
          //   style: TextStyle(fontSize: 15),
          // )),
          backgroundColor: Color.fromARGB(255, 51, 51, 51)),
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
