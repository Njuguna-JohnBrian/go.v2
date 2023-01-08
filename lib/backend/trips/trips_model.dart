import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:go/backend/trips/trips_key.dart';

@immutable
class TripsModel {
  final String userId;
  final String tripId;
  final String tripTitle;
  final String tripSummary;
  final String tripType;
  final DateTime startDate;
  final DateTime endDate;
  final String tripUrl;
  final String profilePicture;
  final double startLongitude;
  final double startLatitude;

  TripsModel({
    required this.tripId,
    required Map<String, dynamic> json,
  })  : userId = json[TripsKey.userId],
        tripTitle = json[TripsKey.tripTitle],
        tripSummary = json[TripsKey.tripSummary],
        tripType = json[TripsKey.tripType],
        startDate = (json[TripsKey.startDate] as Timestamp).toDate(),
        endDate = (json[TripsKey.endDate] as Timestamp).toDate(),
        tripUrl = json[TripsKey.tripUrl],
        profilePicture = json[TripsKey.profilePicture],
        startLongitude = json[TripsKey.startLongitude],
        startLatitude = json[TripsKey.startLatitude];
}
