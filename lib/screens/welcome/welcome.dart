import 'package:flutter/material.dart';
import 'package:go/screens/welcome/welcome_barrel.dart' show WelcomeBody;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeBody()
    );
  }
}
