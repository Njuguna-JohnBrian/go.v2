import 'package:flutter/material.dart';

void main() {
  runApp(const Go());
}

class Go extends StatelessWidget {
  const Go({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gO',
      home: Scaffold(
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
