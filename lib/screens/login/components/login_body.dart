import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/screens/screens_barrel.dart';

import '../../../theme/go_theme.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
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
            LoginTextInputField(
              icon: Icons.email,
              hintText: LoginStrings.enterEmail,
              textEditingController: _emailController,
            ),
            LoginPasswordInputField(
              icon: Icons.password,
              hintText: LoginStrings.enterPassword,
              textEditingController: _passwordController,
            ),
            const LoginButton(),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.12,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordScreen(),
                    ),
                  ),
                  child: Text(
                    LoginStrings.forgotPassword,
                    style: GoTheme.lightTextTheme.headline3?.copyWith(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              LoginStrings.dontHaveAnAccount,
              style: GoTheme.lightTextTheme.headline6,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ),
              ),
              child: Text(
                LoginStrings.createAccount,
                style: GoTheme.lightTextTheme.headline3?.copyWith(
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
