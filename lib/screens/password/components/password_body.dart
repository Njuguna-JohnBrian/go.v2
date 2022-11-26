import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go/screens/password/password_barrel.dart';
import 'package:go/screens/screens_barrel.dart' show LoginScreen;
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
          const PasswordButton(),
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
}
