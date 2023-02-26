import 'package:cloud_firestore/cloud_firestore.dart';

class Trips {
  final String uid;
  final String tripTitle;
  final String tripSummary;
  final String tripType;
  final String startLocation;
  final String tripId;
  final String startDate;
  final String endDate;
  final String tripUrl;
  final String profilePicture;
  final double startLongitude;
  final double startLatitude;
  final List likes;

  const Trips({
    required this.uid,
    required this.tripTitle,
    required this.tripSummary,
    required this.tripType,
    required this.startLocation,
    required this.tripId,
    required this.startDate,
    required this.endDate,
    required this.tripUrl,
    required this.profilePicture,
    required this.startLongitude,
    required this.startLatitude,
    required this.likes,
  });

  static Trips fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Trips(
        uid: snapshot["uid"],
        tripTitle: snapshot["tripTitle"],
        tripSummary: snapshot["tripSummary"],
        tripType: snapshot["tripType"],
        startLocation: snapshot["startLocation"],
        tripId: snapshot["tripId"],
        startDate: snapshot["startDate"],
        endDate: snapshot['endDate'],
        tripUrl: snapshot["tripUrl"],
        profilePicture: snapshot["profilePicture"],
        startLongitude: snapshot["startLongitude"],
        startLatitude: snapshot["startLatitude"],
        likes: snapshot["likes"]);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "tripTitle": tripTitle,
        "tripSummary": tripSummary,
        "tripType": tripType,
        "startLocation": startLocation,
        "tripId": tripId,
        "startDate": startDate,
        "endDate": endDate,
        "tripUrl": tripUrl,
        "profilePicture": profilePicture,
        "startLongitude": startLongitude,
        "startLatitude": startLatitude,
        "likes": likes
      };
}
