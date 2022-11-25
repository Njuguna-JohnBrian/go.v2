import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/screens/login/login_barrel.dart';

import '../../../theme/go_theme.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgPicture.asset(
            LoginAssets.logoSvg,
            height: 100,
          ),
          Text(
            LoginStrings.loginToGo,
            style: GoTheme.lightTextTheme.headline6,
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
          const LoginDivider(),
          const LoginTextInputField(
            icon: Icons.email,
            hintText: LoginStrings.enterEmail,
          ),
          const LoginPasswordInputField(
            icon: Icons.password,
            hintText: LoginStrings.enterPassword,
          ),
          Text(
            LoginStrings.forgotPassword,
            style: GoTheme.lightTextTheme.headline3?.copyWith(
              color: Colors.blueAccent,
            ),
          ),
          const Spacer(),
          Text(
            LoginStrings.dontHaveAnAccount,
            style: GoTheme.lightTextTheme.headline6,
          ),
          Text(
            LoginStrings.createAccount,
            style: GoTheme.lightTextTheme.headline3?.copyWith(
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
