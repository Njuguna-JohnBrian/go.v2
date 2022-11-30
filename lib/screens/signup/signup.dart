import 'package:flutter/material.dart';
import 'package:go/screens/signup/signup_barrel.dart' show SignUpBody;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUpBody(),
    );
  }
}
