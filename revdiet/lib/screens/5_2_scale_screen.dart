import 'package:flutter/material.dart';

class ScaleScreen extends StatefulWidget {
  const ScaleScreen({super.key});

  @override
  State<ScaleScreen> createState() => _ScaleScreenState();
}

class _ScaleScreenState extends State<ScaleScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('scale screen'),);
  }
}