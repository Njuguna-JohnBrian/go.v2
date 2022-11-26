import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './login_input_container.dart';

class LoginTextInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final IconData icon;
  final String hintText;
  const LoginTextInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginTextFieldContainer(
      child: TextField(
        autofillHints: const [AutofillHints.email],
        controller: textEditingController,
        decoration: InputDecoration(
          hintStyle: GoogleFonts.openSans(),
          icon: Icon(
            icon,
            color: Colors.grey.shade400,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
