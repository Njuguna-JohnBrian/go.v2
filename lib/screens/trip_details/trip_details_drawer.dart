import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/go_theme.dart';

class TripDetailsDrawer extends Drawer {
  TripDetailsDrawer({Key? key})
      : super(
    key: key,
    child: Container(
      color: GoTheme.mainColor,
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(
        20,
      ),
      child: SvgPicture.asset(
        'assets/svgs/logo.svg',
        width: 100,
      ),
    ),
  );
}
