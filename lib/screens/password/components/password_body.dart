import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go/screens/password/password_barrel.dart';
import 'package:go/screens/screens_barrel.dart' show LoginScreen;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../globals/globals_barrel.dart';
import '../../../state/providers/providers_barrel.dart';
import '../../../theme/go_theme.dart';

class PasswordBody extends StatefulWidget {
  const PasswordBody({Key? key}) : super(key: key);

  @override
  State<PasswordBody> createState() => _PasswordBodyState();
}

class _PasswordBodyState extends State<PasswordBody> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
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
            icon: Icons.email,
            hintText: PasswordStrings.enterEmail,
            textEditingController: _emailController,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Consumer(
            builder: (_, ref, child) {
              return PasswordButton(voidCallbackAction: () async {
                validator(context);
                await ref
                    .read(
                      authStateProvider.notifier,
                    )
                    .sendResetLink(
                      email: _emailController.text,
                      context: context,
                    );
                _emailController.clear();
              });
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
    );
  }

  void validator(BuildContext context) {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showSnackBar(
        context,
        GlobalAssets.emailRequired,
        GlobalAssets.emailRequiredMessage,
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
