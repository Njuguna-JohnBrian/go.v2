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
          FirebaseFieldName.photoUrl: photoUrl ??
              'https://lh3.googleusercontent.com/pw/AL9nZEVkMJknNMYloprdMv_qc-DATCsYOzqkI4qgFbklig_W-dg7iGTBzMEjuO_kVs6rLtA2_NAsm6gu_RT3b6D4hFO1bdaQ4O61A1xFSdlZ-qjO-4osND4vkRLRNYh4odBbgLSjqCVg8Jy3TGnPPWTFc5rn=w169-h168-no',
        });
}
