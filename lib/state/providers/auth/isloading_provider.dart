import 'package:go/state/providers/auth/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(
      authStateProvider,
    );

    return authState.isLoading;
  },
);
