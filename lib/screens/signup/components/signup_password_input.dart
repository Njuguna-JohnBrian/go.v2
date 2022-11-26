import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup_input_container.dart';

class SignUpPasswordInputField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final IconData icon;
  final String hintText;
  const SignUpPasswordInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<SignUpPasswordInputField> createState() =>
      _LoginPasswordInputFieldState();
}

class _LoginPasswordInputFieldState extends State<SignUpPasswordInputField> {
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
    return SignUpTextFieldContainer(
      child: TextField(
        controller: widget.textEditingController,
        autofillHints: const [AutofillHints.password],
        obscureText: !showPassword,
        decoration: InputDecoration(
          hintStyle: GoogleFonts.openSans(),
          icon: Icon(
            widget.icon,
            color: Colors.grey.shade400,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              showPassword = !showPassword;
            }),
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
