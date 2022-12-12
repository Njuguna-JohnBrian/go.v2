import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:go/globals/globals_barrel.dart';
import 'package:go/theme/go_theme.dart';

showSnackBar(
  BuildContext contextOf,
  String headText,
  String infoText,
  Color boxColor,
  Color bubblesColor,
  Color? failColor,
) {
  ScaffoldMessenger.of(contextOf).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(contextOf).scaffoldBackgroundColor,
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headText,
                        style: GoTheme.darkTextTheme.bodyText1?.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        infoText,
                        style: GoTheme.darkTextTheme.bodyText1?.copyWith(
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
              child: SvgPicture.asset(
                GlobalAssets.bubblesSvg,
                height: 48,
                width: 40,
                color: bubblesColor,
              ),
            ),
          ),
          Positioned(
            top: -13,
            left: 0,
            child: GestureDetector(
              onTap: () =>
                  ScaffoldMessenger.of(contextOf).removeCurrentSnackBar(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    GlobalAssets.failSvg,
                    height: 40,
                    color: failColor,
                  ),
                  Positioned(
                    top: 10,
                    child: SvgPicture.asset(
                      GlobalAssets.closeSvg,
                      height: 16,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
