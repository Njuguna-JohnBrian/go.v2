import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class SettingsSections extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const SettingsSections({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: GoTheme.lightTextTheme.headline3,
            ),
          ),
        Column(
          children: children,
        )
      ],
    );
  }
}
