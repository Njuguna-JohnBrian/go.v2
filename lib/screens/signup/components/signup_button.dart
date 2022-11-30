import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

import 'package:go/screens/signup/signup_barrel.dart' show SignUpStrings;

class SignUpButton extends StatelessWidget {
  final VoidCallback voidCallbackAction;
  const SignUpButton({
    Key? key,
    required this.voidCallbackAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          30,
        ),
        child: TextButton(
          onPressed: voidCallbackAction,
          child: Text(
            SignUpStrings.createAccount,
            style: GoTheme.darkTextTheme.headline3,
          ),
        ),
      ),
    );
  }
}
