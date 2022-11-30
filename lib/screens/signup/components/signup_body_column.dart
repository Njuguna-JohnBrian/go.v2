import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go/theme/go_theme.dart';

import 'package:go/screens/screens_barrel.dart' show LoginScreen;
import 'package:go/screens/signup/signup_barrel.dart'
    show
        SignUpAssets,
        SignUpStrings,
        SignUpEmailInputField,
        SignUpNameInputField,
        SignUpPasswordInputField,
        SignUpConfirmPasswordInputField,
        SignUpButton,
        SignUpPrivacyPolicy;
import 'package:go/state/state_barrel.dart' show authStateProvider;

class SignUpBodyColumn extends StatefulWidget {
  const SignUpBodyColumn({Key? key}) : super(key: key);

  @override
  State<SignUpBodyColumn> createState() => _SignUpBodyColumnState();
}

class _SignUpBodyColumnState extends State<SignUpBodyColumn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose;
    _nameController.dispose;
    _passwordController.dispose;
    _confirmPasswordController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _signUpFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgPicture.asset(
            SignUpAssets.logoSvg,
            height: 100,
          ),
          Text(
            SignUpStrings.newAccount,
            style: GoTheme.lightTextTheme.headline6,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SignUpEmailInputField(
            textEditingController: _emailController,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SignUpNameInputField(
            textEditingController: _nameController,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SignUpPasswordInputField(
            passwordController: _passwordController,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SignUpConfirmPasswordInputField(
            confirmPasswordController: _confirmPasswordController,
            validationStringController: _passwordController,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Consumer(
            builder: (_, ref, child) {
              return SignUpButton(
                voidCallbackAction: () async {
                  if (_signUpFormKey.currentState!.validate()) {
                    await ref
                        .read(
                          authStateProvider.notifier,
                        )
                        .createAccount(
                          email: _emailController.text,
                          password: _passwordController.text,
                          displayName: _nameController.text,
                          context: context,
                        );
                  }
                },
              );
            },
          ),
          const SignUpPrivacyPolicy(),
          const Spacer(),
          Text(
            SignUpStrings.alreadyHaveAccount,
            style: GoTheme.lightTextTheme.headline6,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            ),
            child: Text(
              SignUpStrings.login,
              style: GoTheme.lightTextTheme.headline3?.copyWith(
                color: Colors.blueAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
