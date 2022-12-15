import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class TripsDescriptionSection extends StatefulWidget {
  const TripsDescriptionSection({Key? key}) : super(key: key);

  @override
  State<TripsDescriptionSection> createState() =>
      _TripsDescriptionSectionState();
}

class _TripsDescriptionSectionState extends State<TripsDescriptionSection> {
  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _tripDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    _tripNameController.dispose();
    _tripDescriptionController.dispose();
    super.dispose();
  }

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
                controller: _tripNameController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Please provide trip name/title";
                  } else if (value.length < 3) {
                    return "Please provide a longer trip name";
                  } else {
                    return null;
                  }
                }),
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                controller: _tripDescriptionController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Please a trip summary";
                  } else {
                    return null;
                  }
                }),
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
