import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

import 'package:go/animations/anims/connection.dart' show NoConnectionView;
import 'connection_strings.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NoConnectionView(),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              ConnectionStrings.noInternet,
              style: GoTheme.lightTextTheme.bodyText1
                  ?.copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
