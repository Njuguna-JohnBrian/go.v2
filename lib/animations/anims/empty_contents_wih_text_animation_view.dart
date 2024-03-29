import 'package:flutter/material.dart';
import 'package:go/animations/anims/empty_content_animation_view.dart';
import 'package:go/theme/go_theme.dart';


class EmptyContentsWithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextAnimationView({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              text,
              style: GoTheme.lightTextTheme.bodyLarge?.copyWith(
                fontSize: 20,
              )
            ),
          ),
          const EmptyContentAnimationView(),
        ],
      ),
    );
  }
}
