import 'package:flutter/foundation.dart' show immutable;
import 'package:go/models/userdata/userdata_keys.dart';

@immutable
class AllUsersDataModel {
  final String displayName;
  final String email;
  final String profilePhoto;
  final String userId;
  final String followerId;

  AllUsersDataModel({
    required this.userId,
    required Map<String, dynamic> json,
  })  : displayName = json[UserDataKeys.displayName],
        email = json[UserDataKeys.email],
        followerId = json[UserDataKeys.userId],
        profilePhoto = json[UserDataKeys.profilePhoto];
}
