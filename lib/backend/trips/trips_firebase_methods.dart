import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../image_upload/image_upload.dart';
import 'trips_payload.dart';

class TripFirebaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Upload Trip
  Future<String> uploadTrip(
    String uid,
    String tripTitle,
    String tripSummary,
    String tripType,
    String startLocation,
    String startDate,
    String endDate,
    double startLongitude,
    double startLatitude,
    Uint8List tripCoverImage,
    String? profilePicture,
  ) async {
    String res = "Some error occurred";
    try {
      String photoUrl = await ImageStorageMethods().uploadImageToStorage(
        "trips",
        tripCoverImage,
        true,
      );
      String tripId = const Uuid().v1();

      Trips trips = Trips(
        uid: uid,
        tripTitle: tripTitle,
        tripSummary: tripSummary,
        tripType: tripType,
        startLocation: startLocation,
        tripId: tripId,
        startDate: startDate,
        endDate: endDate,
        tripUrl: photoUrl,
        profilePicture: profilePicture!,
        startLongitude: startLongitude,
        startLatitude: startLatitude,
        likes: [],
        createdAt: Timestamp.now(),
      );

      _firestore.collection("trips").doc(tripId).set(
            trips.toJson(),
          );
      res = "Success,$photoUrl";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //like trip
  Future<void> likeTrip(
    String tripId,
    String uid,
    List likes,
  ) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("trips").doc(tripId).update({
          "likes": FieldValue.arrayRemove(
            [uid],
          )
        });
      } else {
        await _firestore.collection("trips").doc(tripId).update({
          'likes': FieldValue.arrayUnion(
            [uid],
          )
        });
      }
    } catch (e) {
      return;
    }
  }

  //post comment
  Future<String> addComment(
    String tripId,
    String comment,
    String uid,
    String userName,
    String userAvatar,
  ) async {
    String res = "Some error occurred";
    try {
      String commentId = const Uuid().v1();
      await _firestore
          .collection("trips")
          .doc(tripId)
          .collection("comments")
          .doc(commentId)
          .set(
        {
          "userAvatar": userAvatar,
          "userName": userName,
          "uid": uid,
          "comment": comment,
          "commentId": commentId,
          "datePublished": DateTime.now(),
        },
      );
      res = "Success";
    } catch (e) {
      res = "Error";
      return res;
    }
    return res;
  }
}
