import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/theme/go_theme.dart';

import 'package:go/globals/globals_barrel.dart';

class GlobalSpinner extends StatelessWidget {
  final BuildContext context;
  const GlobalSpinner({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(color: Colors.white),
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            GlobalAssets.logoSvg,
            height: 100,
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 90,
            height: 90,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                GoTheme.mainColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
