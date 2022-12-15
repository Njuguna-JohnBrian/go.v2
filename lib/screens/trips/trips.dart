import 'package:flutter/material.dart';
import 'package:go/screens/trips/trips_barrel.dart';
import 'package:go/theme/go_theme.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "New trip",
          style: GoTheme.lightTextTheme.headline6?.copyWith(
            color: GoTheme.mainColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ),
          color: GoTheme.mainColor,
          iconSize: 25,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Center(
              child: Text(
                "Save",
                style: GoTheme.lightTextTheme.headline6?.copyWith(
                  color: GoTheme.mainColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: TripsBody(),
      ),
    );
  }
}
