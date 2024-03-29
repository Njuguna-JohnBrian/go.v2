import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/theme/go_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:go/state/providers/auth/auth_state_provider.dart'
    show authStateProvider;
import 'package:go/screens/login/login_barrel.dart'
    show
        LoginAssets,
        LoginStrings,
        FederatedLoginButton,
        LoginDivider,
        LoginEmailInputField,
        LoginPasswordInputField,
        LoginButton;
import 'package:go/screens/screens_barrel.dart'
    show PasswordScreen, SignUpScreen;

class LoginBody extends ConsumerStatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _LoginBodyState();
}

class _LoginBodyState extends ConsumerState<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

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
        child: Form(
          key: _loginFormKey,
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
                pressAction: () async {
                  await ref
                      .read(authStateProvider.notifier)
                      .loginWithGoogle(context: context);
                },
                buttonText: LoginStrings.continueWithGoogle,
                primaryColor: Colors.grey.shade100,
                textColor: Colors.grey,
                imageLink: LoginAssets.googleLogo,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              FederatedLoginButton(
                pressAction: () async {
                  await ref
                      .read(authStateProvider.notifier)
                      .loginWithFacebook(context: context);
                },
                buttonText: LoginStrings.continueWithFaceBook,
                primaryColor: Colors.blueAccent,
                imageLink: LoginAssets.facebookLogo,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const LoginDivider(),
              SizedBox(
                height: size.height * 0.03,
              ),
              LoginEmailInputField(
                textEditingController: _emailController,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              LoginPasswordInputField(
                passwordController: _passwordController,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Consumer(
                builder: (_, ref, child) {
                  return LoginButton(
                    voidCallbackAction: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        await ref.read(authStateProvider.notifier).loginUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context,
                            );
                      }
                    },
                  );
                },
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
      ),
    );
  }
}
