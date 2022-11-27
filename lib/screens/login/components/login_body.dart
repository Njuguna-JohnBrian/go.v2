import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/state/providers/auth/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:go/globals/globals_barrel.dart';
import 'package:go/screens/login/login_barrel.dart';
import 'package:go/screens/screens_barrel.dart'
    show PasswordScreen, SignUpScreen;

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
            Consumer(
              builder: (_, ref, child) {
                return FederatedLoginButton(
                  pressAction: ref
                      .read(
                        authStateProvider.notifier,
                      )
                      .loginWithGoogle,
                  buttonText: LoginStrings.continueWithGoogle,
                  primaryColor: Colors.grey.shade100,
                  textColor: Colors.grey,
                  imageLink: LoginAssets.googleLogo,
                );
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Consumer(
              builder: (_, ref, child) {
                return FederatedLoginButton(
                  pressAction: ref
                      .read(
                        authStateProvider.notifier,
                      )
                      .loginWithFacebook,
                  buttonText: LoginStrings.continueWithFaceBook,
                  primaryColor: Colors.blueAccent,
                  imageLink: LoginAssets.facebookLogo,
                );
              },
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
            LoginButton(
              voidCallbackAction: () => validator(context),
            ),
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

  void validator(BuildContext context) {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showSnackBar(
        context,
        GlobalAssets.emptyFields,
        GlobalAssets.emptyFieldsMessage,
        GoTheme.mainLightError,
        GoTheme.mainError,
        GoTheme.mainError,
      );
    } else if (_passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showSnackBar(
        context,
        GlobalAssets.tooShort,
        GlobalAssets.passwordTooShortMessage,
        GoTheme.mainLightError,
        GoTheme.mainError,
        GoTheme.mainError,
      );
    } else if (!RegExp(GlobalAssets.passwordPattern)
        .hasMatch(_passwordController.text)) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showSnackBar(
        context,
        GlobalAssets.passwordInvalid,
        GlobalAssets.invalidPasswordMessage,
        GoTheme.mainLightError,
        GoTheme.mainError,
        GoTheme.mainError,
      );
    } else if (!RegExp(GlobalAssets.emailPattern)
        .hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showSnackBar(
        context,
        GlobalAssets.invalidEmail,
        GlobalAssets.invalidEmailMessage,
        GoTheme.mainLightError,
        GoTheme.mainError,
        GoTheme.mainError,
      );
    } else {
      return;
    }
  }
}
