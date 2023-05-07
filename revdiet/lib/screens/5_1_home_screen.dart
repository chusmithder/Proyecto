import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revdiet/components/1_custom_text_field.dart';
import 'package:revdiet/components/2_custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // final user = FirebaseAuth.instance.currentUser!;

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  void _logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('sign as ' + widget.user.email!),
              const SizedBox(height: 25),
              GestureDetector(
                child: const Text('RevDiet',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 66, 204, 137))),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 94, 94, 94),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Calories',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '1000',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 66, 204, 137),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            '/',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            '2500',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 10,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 66, 204, 137),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            height: 10,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
