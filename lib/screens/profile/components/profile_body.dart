import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/globals/globals_barrel.dart';
import 'package:go/models/models_barrel.dart';
import 'package:go/theme/go_theme.dart';

import '../utils/strings.dart';

class ProfileBody extends StatelessWidget {
  final UserDataModel userData;
  const ProfileBody({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          elevation:0,
          expandedHeight: size.height * 0.35,
          backgroundColor: Colors.transparent,
          leading: SvgPicture.asset(
            GlobalAssets.logoSvg,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: GoTheme.mainColor,
                size: 35,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: GoTheme.mainColor,
                size: 35,
              ),
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ProfileStrings.worldMap,
                  ),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
