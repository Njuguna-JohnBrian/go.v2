import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go/globals/globals_barrel.dart';
import 'package:go/theme/go_theme.dart';
import 'package:image_picker/image_picker.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  final GlobalKey<FormState> _tripsFormKey = GlobalKey<FormState>();
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
              padding: const EdgeInsets.all(20),
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
              padding: const EdgeInsets.all(20),
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
}
