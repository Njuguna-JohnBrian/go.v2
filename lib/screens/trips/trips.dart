import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go/globals/globals_barrel.dart';
import 'package:go/theme/go_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  final GlobalKey<FormState> _tripsFormKey = GlobalKey<FormState>();
  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _tripDescriptionController =
      TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  Uint8List? coverImage;

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
                onTap: () {
                  if (_tripsFormKey.currentState!.validate()) {
                    print(coverImage?.isEmpty);
                    print(coverImage);
                  }
                },
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
      body: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.045,
          right: size.width * 0.045,
        ),
        child: Form(
          key: _tripsFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buildImageSelector(
                      context: context,
                      size: size,
                    ),
                    buildPadding(
                      context: context,
                    ),
                    buildDescription(
                      context: context,
                      size: size,
                    ),
                    buildPadding(
                      context: context,
                    ),
                    buildCalendarSection(
                      context: context,
                      size: size,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageSelector({
    required BuildContext context,
    required Size size,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.01,
      ),
      child: Row(
        children: [
          coverImage == null
              ? DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(
                    10,
                  ),
                  color: Colors.grey,
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  strokeWidth: 1,
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                    ),
                    iconSize: 25,
                    color: Colors.grey,
                    onPressed: () {
                      buildImageDialog(
                        context: context,
                        size: size,
                      );
                    },
                  ),
                )
              : Container(
                  height: size.height * 0.11,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    image: DecorationImage(
                      image: MemoryImage(
                        coverImage!,
                      ),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
          SizedBox(
            width: size.width * 0.10,
          ),
          GestureDetector(
            onTap: () async {
              await buildImageDialog(
                context: context,
                size: size,
              );
            },
            child: Container(
              height: size.height * 0.04,
              width: size.width * 0.4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: coverImage != null
                      ? Colors.black.withOpacity(
                          0.4,
                        )
                      : Colors.redAccent,
                ),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Text(
                coverImage != null
                    ? "Change cover photo"
                    : "Upload cover photo",
                style: GoTheme.darkTextTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> buildImageDialog({
    required BuildContext context,
    required Size size,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Select Trip Cover Photo"),
          titleTextStyle: GoTheme.lightTextTheme.headline6,
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
              child: Row(
                children: [
                  const Icon(
                    Icons.camera,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Take a picture",
                    style: GoTheme.lightTextTheme.headline6,
                  ),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();

                Uint8List selectedImage = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  coverImage = selectedImage;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(
                20,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.browse_gallery,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Select from gallery",
                    style: GoTheme.lightTextTheme.headline6,
                  ),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();

                Uint8List selectedImage = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  coverImage = selectedImage;
                });
              },
            ),
            Center(
              child: SimpleDialogOption(
                padding: const EdgeInsets.all(
                  20,
                ),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    minimumSize: const Size(
                      100,
                      35,
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
  }

  Widget buildPadding({required BuildContext context}) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 30.0,
        bottom: 30.0,
      ),
      child: Divider(
        thickness: 2,
      ),
    );
  }

  Widget buildDescription({required BuildContext context, required Size size}) {
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
              width: size.width * 0.12,
            ),
            SizedBox(
              width: size.width * 0.70,
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
                  labelText: "Trip Name/Title",
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: 'e.g African Road Trip',
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
              width: size.width * 0.12,
            ),
            SizedBox(
              width: size.width * 0.70,
              child: TextFormField(
                controller: _tripDescriptionController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Please provide a trip summary";
                  } else if (value.length < 3) {
                    return "Please provide a longer trip summary";
                  } else {
                    return null;
                  }
                }),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Trip Summary',
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText:
                      'e.g An awesome road trip through the desserts on Africa with my family',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildCalendarSection(
      {required BuildContext context, required Size size}) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.12,
            ),
            SizedBox(
              width: size.width * 0.70,
              child: TextFormField(
                controller: _startDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Start Date",
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: DateFormat("MMMM dd yyyy").format(
                    DateTime.now(),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                      DateTime.now().year + 5,
                    ),
                    helpText: "Select start date",
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: GoTheme.mainColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((value) {
                    if (value != null) {
                      _startDateController.text =
                          DateFormat("MMMM dd yyyy").format(
                        value,
                      );
                    }
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.today_sharp,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.12,
            ),
            SizedBox(
              width: size.width * 0.70,
              child: TextFormField(
                controller: _endDateController,
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Please provide an end date";
                  } else {
                    return null;
                  }
                }),
                decoration: InputDecoration(
                  labelText: "End Date",
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: "End Date",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                      DateTime.now().year + 5,
                    ),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: GoTheme.mainColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then(
                    (value) {
                      if (value != null) {
                        _endDateController.text = DateFormat(
                          "MMMM dd yyyy",
                        ).format(
                          value,
                        );
                      }
                    },
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
