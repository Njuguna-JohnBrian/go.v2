import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class TripsDescriptionSection extends StatelessWidget {
  const TripsDescriptionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.title,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.10,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Trip Name/Title',
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: 'e.g African Road trip',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.summarize_outlined,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.10,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: TextFormField(
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Trip summary',
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText:
                  'e.g An awesome road trip through the desserts on Africa with my family',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
