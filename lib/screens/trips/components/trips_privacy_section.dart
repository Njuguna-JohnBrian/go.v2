import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class TripsPrivacySection extends StatefulWidget {
  const TripsPrivacySection({Key? key}) : super(key: key);

  @override
  State<TripsPrivacySection> createState() => _TripsPrivacySectionState();
}

class _TripsPrivacySectionState extends State<TripsPrivacySection> {
  final TextEditingController _tripPrivacyController = TextEditingController(
    text: "Public",
  );

  @override
  void dispose() {
    _tripPrivacyController.dispose();
    super.dispose();
  }

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
            controller: _tripPrivacyController,
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  String privacyValue = "Public";
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      void handlePrivacyChange(String? value) {
                        setState(() {
                          privacyValue = value!;
                          _tripPrivacyController.text = value;
                        });
                      }

                      return SimpleDialog(
                        title: const Text(
                          "Select who can see your trip",
                        ),
                        titleTextStyle: GoTheme.lightTextTheme.headline2,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        children: [
                          SimpleDialogOption(
                            padding: const EdgeInsets.all(
                              20,
                            ),
                            child: ListTile(
                              title: Text(
                                "Private",
                                style: GoTheme.lightTextTheme.headline2,
                              ),
                              leading: Transform.scale(
                                scale: 1.5,
                                child: Radio(
                                  value: "Private",
                                  groupValue: privacyValue,
                                  onChanged: handlePrivacyChange,
                                  activeColor: GoTheme.mainColor,
                                ),
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            padding: const EdgeInsets.all(
                              20,
                            ),
                            child: ListTile(
                              title: Text(
                                "Public",
                                style: GoTheme.lightTextTheme.headline2,
                              ),
                              leading: Transform.scale(
                                scale: 1.5,
                                child: Radio(
                                  value: "Public",
                                  groupValue: privacyValue,
                                  onChanged: handlePrivacyChange,
                                  activeColor: GoTheme.mainColor,
                                ),
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            padding: const EdgeInsets.all(
                              20,
                            ),
                            child: ListTile(
                              title: Text(
                                "Premium",
                                style: GoTheme.lightTextTheme.headline2,
                              ),
                              leading: Transform.scale(
                                scale: 1.5,
                                child: Radio(
                                  value: "Premium",
                                  groupValue: privacyValue,
                                  onChanged: handlePrivacyChange,
                                  activeColor: GoTheme.mainColor,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: SimpleDialogOption(
                              padding: const EdgeInsets.all(
                                20,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  minimumSize: const Size(
                                    150,
                                    50,
                                  ),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: GoTheme.darkTextTheme.headline3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Type of trip',
              labelStyle: GoTheme.lightTextTheme.headline6,
              hintText: "Select to define who sees this trip",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ],
    );
  }
}
