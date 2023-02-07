import 'package:flutter/foundation.dart' show immutable;
import 'package:go/models/userdata/userdata_keys.dart';

@immutable
class UserDataModel {
  final String displayName;
  final String email;
  final List followers;
  final List following;
  final String profilePhoto;
  final String userId;

  UserDataModel({
    required this.userId,
    required Map<String, dynamic> json,
  })  : displayName = json[UserDataKeys.displayName],
        email = json[UserDataKeys.email],
        followers = json[UserDataKeys.followers] ?? [],
        following = json[UserDataKeys.following] ?? [],
        profilePhoto = json[UserDataKeys.profilePhoto];
}
