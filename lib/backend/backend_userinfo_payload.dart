import 'dart:collection' show MapView;
import 'package:flutter/foundation.dart' show immutable;

import '../typedefs/typedefs_barrel.dart';
import 'constants/backend_constants_barrel.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
    required String? photoUrl,
    required List? following,
    required List? followers,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName ?? '',
          FirebaseFieldName.email: email ?? '',
          FirebaseFieldName.photoUrl: photoUrl ?? '',
        });
}
