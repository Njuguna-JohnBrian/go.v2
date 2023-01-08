import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserDataKeys {
  static const displayName = "display_name";
  static const email = "email";
  static const followers = "followers";
  static const following = "following";
  static const profilePhoto = "photo_url";
  static const userId = "uid";
  const UserDataKeys._();
}
