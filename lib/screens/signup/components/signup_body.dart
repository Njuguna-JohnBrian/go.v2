import 'package:flutter/material.dart';

import 'package:go/screens/signup/signup_barrel.dart' show SignUpBodyColumn;

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: const SignUpBodyColumn(),
      ),
    );
  }
}
