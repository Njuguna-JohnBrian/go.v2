import 'package:flutter/material.dart';

import 'package:go/screens/screens_barrel.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PasswordBody(),
    );
  }
}
