import 'package:flutter/material.dart';
import 'package:go/screens/welcome/welcome_barrel.dart' show WelcomeStrings;
import 'package:go/screens/screens_barrel.dart' show LoginScreen;
import 'package:go/theme/go_theme.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({Key? key}) : super(key: key);

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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          ),
          child: Text(
            WelcomeStrings.continueToLogin,
            style: GoTheme.darkTextTheme.headline6,
          ),
        ),
      ),
    );
  }
}
