import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';
import 'package:go/screens/login/login_barrel.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.20,
      ),
      child: Row(
        children:  const [
          Expanded(
            child: Divider(
              color:GoTheme.mainGreyColor,
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Text(
              LoginStrings.or,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: GoTheme.mainGreyColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
