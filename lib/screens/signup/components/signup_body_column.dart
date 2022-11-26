import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/screens/screens_barrel.dart' show LoginScreen;

import 'package:go/screens/signup/signup_barrel.dart';
import 'package:go/theme/go_theme.dart';

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
        const SignUpButton(),
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
}
