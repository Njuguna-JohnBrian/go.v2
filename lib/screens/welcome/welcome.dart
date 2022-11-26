import 'package:flutter/material.dart';
import 'package:go/screens/welcome/welcome_barrel.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeBody()
    );
  }
}
