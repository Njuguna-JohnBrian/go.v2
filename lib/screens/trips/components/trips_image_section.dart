import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go/globals/globals_barrel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go/theme/go_theme.dart';

typedef ImageCallback = void Function(Uint8List imageDate);

class TripsImageSection extends StatefulWidget {
  final ImageCallback onImageSelected;
  const TripsImageSection({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<TripsImageSection> createState() => _TripsImageSectionState();
}

class _TripsImageSectionState extends State<TripsImageSection> {
  Uint8List? _coverImage;

  getImage() {
    return _coverImage;
  }

  _selectTripImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "Select Trip Cover Photo",
          ),
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
                Uint8List selectedCameraImage = await pickImage(
                  ImageSource.camera,
                );

                setState(() {
                  _coverImage = selectedCameraImage;
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

                Uint8List selectedGalleryImage = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  _coverImage = selectedGalleryImage;
                });
                widget.onImageSelected(_coverImage!);
              },
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.01,
      ),
      child: Row(
        children: [
          _coverImage != null
              ? Container(
                  height: size.height * 0.11,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: MemoryImage(
                        _coverImage!,
                      ),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                )
              : DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  color: Colors.grey,
                  padding: const EdgeInsets.all(20),
                  strokeWidth: 1,
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                    ),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () async {
                      await _selectTripImage(context);
                    },
                  ),
                ),
          SizedBox(
            width: size.width * 0.10,
          ),
          GestureDetector(
            onTap: () async {
              await _selectTripImage(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: _coverImage != null
                      ? Colors.black.withOpacity(
                          0.4,
                        )
                      : Colors.redAccent,
                ),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              alignment: Alignment.center,
              width: size.width * 0.35,
              height: size.height * 0.04,
              child: Text(
                _coverImage != null
                    ? "Change cover photo"
                    : "Upload cover photo",
                style: GoTheme.darkTextTheme.bodyText1?.copyWith(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
