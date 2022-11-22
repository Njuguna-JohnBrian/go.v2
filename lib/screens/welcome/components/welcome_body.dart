import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../welcome_barrel.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(
        11.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.25,
          ),
          SvgPicture.asset(
            WelcomeAssets.goSvgLogo,
            height: 100,
          ),
        ],
      ),
    );
  }
}
