import 'package:go/state/providers/auth/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = Provider(
  (ref) => ref
      .watch(
        authStateProvider,
      )
      .userId,
);
