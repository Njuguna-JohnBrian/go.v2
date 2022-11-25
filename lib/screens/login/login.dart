import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/theme/go_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:go/state/state_barrel.dart';
import 'package:go/screens/login/login_barrel.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              LoginAssets.logoSvg,
              height: 100,
            ),
            Text(
              LoginStrings.loginToGo,
              style: GoTheme.lightTextTheme.headline2,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            FederatedLoginButton(
              pressAction: () {},
              buttonText: LoginStrings.continueWithGoogle,
              primaryColor: Colors.grey.shade100,
              textColor: Colors.grey,
              imageLink: LoginAssets.googleLogo,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            FederatedLoginButton(
              pressAction: () {},
              buttonText: LoginStrings.continueWithFaceBook,
              primaryColor: Colors.blueAccent,
              imageLink: LoginAssets.facebookLogo,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const LoginDivider()
          ],
        ),
      ),
    );
  }
}
