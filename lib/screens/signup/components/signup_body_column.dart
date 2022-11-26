import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/screens/screens_barrel.dart' show LoginScreen;

import 'package:go/screens/signup/signup_barrel.dart';
import 'package:go/theme/go_theme.dart';

import '../../../globals/globals_barrel.dart';

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
    return Column(
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
        SignUpEmailInputField(
          icon: Icons.email,
          hintText: SignUpStrings.enterEmail,
          textEditingController: _emailController,
        ),
        SignUpNameInputField(
          icon: Icons.keyboard_alt_outlined,
          hintText: SignUpStrings.enterName,
          textEditingController: _nameController,
        ),
        SignUpPasswordInputField(
          icon: Icons.password,
          hintText: SignUpStrings.enterPassword,
          textEditingController: _passwordController,
        ),
        SignUpPasswordInputField(
          icon: Icons.password,
          hintText: SignUpStrings.confirmPassword,
          textEditingController: _confirmPasswordController,
        ),
        SignUpButton(
          voidCallbackAction: () => validator(context),
        ),
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
    );
  }

  void validator(BuildContext context) {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showSnackBar(
        context,
        GlobalAssets.emptyFields,
        GlobalAssets.emptyFieldsMessage,
        GoTheme.mainLightError,
        GoTheme.mainError,
        GoTheme.mainError,
      );
    } else if (!RegExp(GlobalAssets.stringsPattern)
        .hasMatch(_nameController.text)) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showSnackBar(
        context,
        GlobalAssets.nameError,
        GlobalAssets.nameErrorMessage,
        GoTheme.mainLightError,
        GoTheme.mainError,
        GoTheme.mainError,
      );
    } else if (_nameController.text.length < 4) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showSnackBar(
        context,
        GlobalAssets.nameTooShort,
        GlobalAssets.nameTooShortError,
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
    } else if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showSnackBar(
        context,
        GlobalAssets.passwordMismatch,
        GlobalAssets.passwordMismatchError,
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
