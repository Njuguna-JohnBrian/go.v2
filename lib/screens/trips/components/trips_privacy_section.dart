import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class TripsPrivacySection extends StatelessWidget {
  const TripsPrivacySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        const Icon(
          Icons.privacy_tip_outlined,
          color: Colors.grey,
          size: 30,
        ),
        SizedBox(
          width: size.width * 0.10,
        ),
        SizedBox(
          width: size.width * 0.75,
          child: TextFormField(
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Who can see this trip?'),
                    content: const Text(
                        'A dialog is a type of modal window that\n'
                            'appears in front of app content to\n'
                            'provide critical information, or prompt\n'
                            'for a decision to be made.'),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle:
                          Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Disable'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle:
                          Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Enable'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Who can view this trip?',
              labelStyle: GoTheme.lightTextTheme.headline6,
              hintText: "My Followers",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ],
    );
  }
}
