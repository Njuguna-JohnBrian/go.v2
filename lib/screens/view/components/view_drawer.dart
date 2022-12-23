import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/theme/go_theme.dart';



class ViewDrawer extends Drawer {
  ViewDrawer({Key? key})
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
