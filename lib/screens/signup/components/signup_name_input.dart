import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:go/screens/signup/signup_barrel.dart' show SignUpStrings;
import 'package:go/globals/globals_barrel.dart' show GlobalAssets;

class SignUpNameInputField extends StatelessWidget {
  final TextEditingController? textEditingController;

  const SignUpNameInputField({
    Key? key,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.10,
        right: size.width * 0.10,
      ),
      child: TextFormField(
        controller: textEditingController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.grey,
        validator: ((value) {
          if (value!.isEmpty) {
            return SignUpStrings.nameEmpty;
          } else if (!RegExp(GlobalAssets.stringsPattern).hasMatch(value)) {
            return GlobalAssets.nameErrorMessage;
          } else if (value.length < 4) {
            return GlobalAssets.nameTooShortError;
          } else {
            return null;
          }
        }),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          prefixIcon: Icon(
            Icons.keyboard,
            color: Colors.grey.shade400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              30.0,
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              30.0,
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              30.0,
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          labelText: SignUpStrings.enterName,
          labelStyle: GoogleFonts.openSans().copyWith(
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
