import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:go/globals/globals_barrel.dart' show GlobalAssets;
import 'package:go/screens/password/password_barrel.dart' show PasswordStrings;

class PasswordTextInputField extends StatelessWidget {
  final TextEditingController inputController;
  const PasswordTextInputField({
    Key? key,
    required this.inputController,
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
        controller: inputController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.grey,
        validator: ((value) {
          if (value!.isEmpty) {
            return GlobalAssets.emailRequiredMessage;
          } else if (!RegExp(GlobalAssets.emailPattern).hasMatch(value)) {
            return GlobalAssets.invalidEmailMessage;
          } else {
            return null;
          }
        }),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          prefixIcon: Icon(
            Icons.email,
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
          labelText: PasswordStrings.enterEmail,
          labelStyle: GoogleFonts.openSans().copyWith(
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
