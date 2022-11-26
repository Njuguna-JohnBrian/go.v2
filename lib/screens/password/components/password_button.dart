import 'package:flutter/material.dart';
import 'package:go/screens/password/password_barrel.dart';
import 'package:go/theme/go_theme.dart';

class PasswordButton extends StatelessWidget {
  const PasswordButton({Key? key}) : super(key: key);

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
          onPressed: () {},
          child: Text(
            PasswordStrings.getResetLink,
            style: GoTheme.darkTextTheme.headline3,
          ),
        ),
      ),
    );
  }
}
