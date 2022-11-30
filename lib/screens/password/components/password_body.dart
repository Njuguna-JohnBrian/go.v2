import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go/theme/go_theme.dart';

import 'package:go/screens/password/password_barrel.dart'
    show
        PasswordStrings,
        PasswordAssets,
        PasswordTextInputField,
        PasswordButton;
import 'package:go/screens/screens_barrel.dart' show LoginScreen;
import 'package:go/state/providers/providers_barrel.dart'
    show authStateProvider;

class PasswordBody extends StatefulWidget {
  const PasswordBody({Key? key}) : super(key: key);

  @override
  State<PasswordBody> createState() => _PasswordBodyState();
}

class _PasswordBodyState extends State<PasswordBody> {
  final TextEditingController _emailController = TextEditingController();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Form(
        key: _passwordFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            SvgPicture.asset(
              PasswordAssets.logoSvg,
              height: 100,
            ),
            Text(
              PasswordStrings.forgotPassword,
              style: GoTheme.lightTextTheme.headline3,
            ),
            SizedBox(
              height: size.height * 0.10,
            ),
            PasswordTextInputField(
              inputController: _emailController,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Consumer(
              builder: (_, ref, child) {
                return PasswordButton(
                  voidCallbackAction: () async {
                    if (_passwordFormKey.currentState!.validate()) {
                      await ref
                          .read(
                            authStateProvider.notifier,
                          )
                          .sendResetLink(
                            email: _emailController.text,
                            context: context,
                          );
                      _emailController.clear();
                    }
                  },
                );
              },
            ),
            const Spacer(),
            Text(
              PasswordStrings.rememberPassword,
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
                PasswordStrings.login,
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
