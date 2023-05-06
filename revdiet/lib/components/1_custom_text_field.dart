import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscuredText;
  final icon;
  final TextInputType inputType;

  const CustomTextField(
      {required this.controller,
      required this.hintText,
      required this.obscuredText,
      required this.icon,
      required this.inputType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: controller,
        obscureText: obscuredText,
        style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 66, 204, 137)),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 66, 204, 137)),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon:
              Icon(icon, color: Color.fromARGB(255, 66, 204, 137)),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
        ),
        keyboardType: inputType,
      ),
    );
  }
}
