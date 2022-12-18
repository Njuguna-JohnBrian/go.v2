import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:go/backend/userinfo/backend_userinfo_payload.dart';
import 'package:go/backend/constants/backend_constants_barrel.dart';
import 'package:go/typedefs/typedefs_barrel.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
    required String? photoUrl,
  }) async {
    try {
      //check if user exists
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();

      //if exists
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
          FirebaseFieldName.photoUrl: photoUrl,
        });
        return true;
      }
      // new user
      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
        photoUrl: photoUrl,
        followers: const [],
        following: const [],
      );

      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .doc(userId)
          .set(
            payload,
          );
      return true;
    } catch (e) {
      return false;
    }
  }
}
