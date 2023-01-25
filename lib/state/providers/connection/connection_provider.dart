import 'package:go/state/notifiers/notifiers_barrel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final networkAwareProvider = StateNotifierProvider((ref) {
  return NetworkDetectorNotifier();
});
