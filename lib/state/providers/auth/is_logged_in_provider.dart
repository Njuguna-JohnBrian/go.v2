import 'package:go/models/models_barrel.dart';
import 'package:go/state/providers/auth/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoggedInProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(
      authStateProvider,
    );

    return authState.result == AuthResult.success;
  },
);
