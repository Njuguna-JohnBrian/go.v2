import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/screens/screens_barrel.dart';
import 'package:go/theme/go_theme.dart';

class WelcomeBodyColumn extends StatelessWidget {
  const WelcomeBodyColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.25,
        ),
        SvgPicture.asset(
          WelcomeAssets.goSvgLogo,
          height: 100,
        ),
        Text(
          WelcomeStrings.seeWhatsHappening,
          style: GoTheme.lightTextTheme.headline1,
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        const WelcomeButton(),
        const Spacer(),
        Text(
          WelcomeStrings.dontHaveAnAccount,
          style: GoTheme.lightTextTheme.headline2,
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUpScreen(),
            ),
          ),
          child: Text(
            WelcomeStrings.createAnAccount,
            style: GoTheme.lightTextTheme.headline6?.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
