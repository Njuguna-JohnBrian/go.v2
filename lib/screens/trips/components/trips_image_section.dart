import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go/theme/go_theme.dart';

class TripsImageSection extends StatelessWidget {
  const TripsImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        DottedBorder(
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
              onPressed: () {},
            )),
        SizedBox(
          width: size.width * 0.10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.black.withOpacity(
                0.4,
              ),
            ),
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          alignment: Alignment.center,
          width: size.width * 0.35,
          height: size.height * 0.04,
          child: Text(
            "Change cover photo",
            style: GoTheme.darkTextTheme.bodyText1?.copyWith(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
