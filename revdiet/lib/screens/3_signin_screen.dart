import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
    
  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    print('asdsasaddas');
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        // margin: const EdgeInsets.only(top: 100, bottom: 100),
        color: Color.fromARGB(255, 51, 51, 51),
        padding: const EdgeInsets.only(right: 90, left: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text('Hello', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
            const Text('Sign in into your account', style: TextStyle(fontSize: 20, color: Colors.grey)),
            const SizedBox(height: 50),
            TextFormField(
              style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 66, 204, 137)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 66, 204, 137)),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                prefixIcon: Icon(Icons.mail, color: Color.fromARGB(255, 66, 204, 137)),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 66, 204, 137)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 66, 204, 137)),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 66, 204, 137)),
                hintText: "Contraseña",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
              ),
            ),
            const SizedBox(height: 30), 
            Container(
              width: 250,
              height: 40,
              color: Color.fromARGB(255, 66, 204, 137),
              child: MaterialButton(
                onPressed: () {},
                child: const Center(
                  child: Text('LOGIN', style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}