import 'package:flutter/foundation.dart' show immutable;

@immutable
class GlobalAssets {
  static const bubblesSvg = "assets/icons/bubbles.svg";
  static const failSvg = "assets/icons/fail.svg";

  static const closeSvg = "assets/icons/close.svg";
  static const logoSvg = "assets/svgs/logo.svg";

  static const passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const emailPattern =
      r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$";

  static const stringsPattern = "[a-zA-Z]";

  static const nameError = "Name error";
  static const nameErrorMessage = "Please use only letters for your name";

  static const errorHeader = "Error";
  static const emptyFields = "Empty fields";
  static const emptyFieldsMessage = "Please fill all fields";

  static const tooShort = "Too short";
  static const passwordTooShortMessage =
      "Password must have 8 or more characters";

  static const passwordInvalid = "Invalid password";
  static const invalidPasswordMessage =
      "Password must contain a number, uppercase & lowercase letters and a special character";

  static const invalidEmail = "Invalid email";
  static const invalidEmailMessage = "Please provide a valid email address";

  static const passwordMismatch = "Passwords mismatch";
  static const passwordMismatchError = "Please ensure passwords match";

  static const nameTooShort = "Name too short";
  static const nameTooShortError = "Please ensure your name is 4 characters and above";

  static const successHeader = "Success";
  static const goodBye = "Hope to see you soon.Bye 👋👋";

  const GlobalAssets._();
}
