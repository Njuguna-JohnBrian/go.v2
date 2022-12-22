import 'package:go/models/location_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationStateNotifier extends StateNotifier<LocationState> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  LocationStateNotifier()
      : super(
          const LocationState.unknown(),
        );

  Future<void> getLocation() async {
    final position = await _geolocatorPlatform.getCurrentPosition();

    state = LocationState(
      currentLatitude: position.latitude,
      currentLongitude: position.longitude,
    );
  }
}
