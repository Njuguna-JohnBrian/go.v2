import 'package:flutter/material.dart';
import './login_input_container.dart';

class LoginPasswordInputField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final IconData icon;
  final String hintText;
  const LoginPasswordInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<LoginPasswordInputField> createState() =>
      _LoginPasswordInputFieldState();
}

class _LoginPasswordInputFieldState extends State<LoginPasswordInputField> {
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
    return LoginTextFieldContainer(
      child: TextField(
        controller: widget.textEditingController,
        obscureText: !showPassword,
        decoration: InputDecoration(
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
