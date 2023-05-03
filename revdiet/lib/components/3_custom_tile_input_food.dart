import 'package:flutter/material.dart';

class CustomTileInputFood extends StatelessWidget {
  final controller;
  final String rightText;
  final TextInputType inputType;

  const CustomTileInputFood({
    required this.controller,
    required this.rightText,
    required this.inputType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              rightText,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            flex: 2,
            child: TextField(
              controller: controller,
              keyboardType: inputType,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 66, 204, 137), width: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Introducir',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
