import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "New trip",
          style: GoTheme.lightTextTheme.headline6?.copyWith(
            color: GoTheme.mainColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: GoTheme.mainColor,
            size: 35,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.045,
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Save",
                  style: GoTheme.lightTextTheme.headline6
                      ?.copyWith(color: GoTheme.mainColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
