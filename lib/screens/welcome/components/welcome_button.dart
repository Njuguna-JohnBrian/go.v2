import 'package:flutter/material.dart';
import 'package:go/screens/screens_barrel.dart';
import 'package:go/theme/go_theme.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextButton(
          onPressed: () {},
          child: Text(
            WelcomeStrings.continueToLogin,
            style: GoTheme.darkTextTheme.headline6,
          ),
        ),
      ),
    );
  }
}
