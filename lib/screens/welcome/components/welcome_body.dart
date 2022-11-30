import 'package:flutter/material.dart';
import 'package:go/screens/welcome/welcome_barrel.dart' show WelcomeBodyColumn;

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(
        11.0,
      ),
      child: WelcomeBodyColumn(),
    );
  }
}
