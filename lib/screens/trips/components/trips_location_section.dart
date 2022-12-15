import 'package:flutter/material.dart';

import 'package:go/theme/go_theme.dart';


class TripsLocationSection extends StatelessWidget {
  const TripsLocationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: Colors.grey,
          size: 30,
        ),
        SizedBox(
          width: size.width * 0.08,
        ),
        SizedBox(
          width: size.width * 0.45,
          child: TextFormField(
            onTap: () {},
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Travel Tracker',
              labelStyle: GoTheme.lightTextTheme.headline6,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.16,
        ),
        Switch(value: false, onChanged: (value) {})
      ],
    );
  }
}
