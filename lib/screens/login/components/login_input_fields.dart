import 'package:flutter/material.dart';
import './login_input_container.dart';

class LoginTextInputField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final IconData icon;
  final String hintText;
  const LoginTextInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginTextFieldContainer(
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
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
