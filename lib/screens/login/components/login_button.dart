import 'package:flutter/material.dart';
import 'package:go/screens/login/login_barrel.dart';
import 'package:go/theme/go_theme.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          30,
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            LoginStrings.login,
            style: GoTheme.darkTextTheme.headline6,
          ),
        ),
      ),
    );
  }
}
