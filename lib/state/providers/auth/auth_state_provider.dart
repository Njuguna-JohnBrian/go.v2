import 'package:go/models/models_barrel.dart';
import 'package:go/state/notifiers/notifiers_barrel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
