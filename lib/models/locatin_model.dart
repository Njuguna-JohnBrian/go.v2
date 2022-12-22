import 'package:flutter/foundation.dart' show immutable;

@immutable
class LocationState {
  final double? currentLatitude;
  final double? currentLongitude;

  const LocationState(
      {required this.currentLatitude, required this.currentLongitude});

  const LocationState.unknown()
      : currentLatitude = null,
        currentLongitude = null;

  @override
  bool operator ==(covariant LocationState other) =>
      identical(this, other) ||
      (currentLatitude == other.currentLatitude &&
          currentLongitude == other.currentLongitude);

  @override
  int get hashCode => Object.hash(
        currentLatitude,
        currentLongitude,
      );
}
