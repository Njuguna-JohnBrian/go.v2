import 'package:flutter/foundation.dart' show immutable;

@immutable
class TripsKey {
  static const userId = "uid";
  static const tripId = "tripId";
  static const tripTitle = "tripTitle";
  static const tripSummary = "tripSummary";
  static const tripType = "tripType";
  static const startDate = "startDate";
  static const endDate = "endDate";
  static const tripUrl = "tripUrl";
  static const profilePicture = "profilePicture";
  static const startLongitude = "startLongitude";
  static const startLatitude = "startLatitude";

  const TripsKey._();
}
