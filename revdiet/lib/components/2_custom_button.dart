import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;

  const CustomButton({
    required this.onTap,
    required this.buttonText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 66, 204, 137),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        
      ),
    );
  }
}
