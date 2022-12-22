import 'package:go/models/location_model.dart';
import 'package:go/state/notifiers/location/location_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationStateProvider =
    StateNotifierProvider<LocationStateNotifier, LocationState>(
  (_) => LocationStateNotifier(),
);
