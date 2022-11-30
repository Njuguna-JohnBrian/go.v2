import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:go/globals/global_assets.dart' show GlobalAssets;
import 'package:go/screens/signup/signup_barrel.dart' show SignUpStrings;

class SignUpConfirmPasswordInputField extends StatefulWidget {
  final TextEditingController confirmPasswordController;
  final TextEditingController validationStringController;
  const SignUpConfirmPasswordInputField({
    Key? key,
    required this.confirmPasswordController,
    required this.validationStringController,
  }) : super(key: key);

  @override
  State<SignUpConfirmPasswordInputField> createState() =>
      _LoginPasswordInputFieldState();
}

class _LoginPasswordInputFieldState
    extends State<SignUpConfirmPasswordInputField> {
  bool showPassword = false;

  @override
  void initState() {
    showPassword = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.10,
        right: size.width * 0.10,
      ),
      child: TextFormField(
        obscureText: !showPassword,
        controller: widget.confirmPasswordController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: Colors.grey,
        validator: ((value) {
          if (value!.isEmpty) {
            return SignUpStrings.passwordEmpty;
          } else if (!RegExp(GlobalAssets.passwordPattern).hasMatch(value)) {
            return GlobalAssets.invalidPasswordMessage;
          } else if (value.toString() != widget.validationStringController.text.toString()) {
            return GlobalAssets.passwordMismatchError;
          } else {
            return null;
          }
        }),
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              showPassword = !showPassword;
            }),
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey.shade400,
            ),
          ),
          prefixIcon: Icon(
            Icons.password,
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
          labelText: SignUpStrings.confirmPassword,
          labelStyle: GoogleFonts.openSans().copyWith(
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
