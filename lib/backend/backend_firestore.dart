import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go/backend/constants/backend_constants_barrel.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Get user information
  Future getUserData() async {
    try {
      final userData = await _firestore
          .collection(FirebaseCollectionName.users)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      return userData.data()!;
    } catch (e) {}
  }

  //Follow and unfollow users
  Future<void> followUnfollowUser(String uid, String followId) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection(
            FirebaseCollectionName.users,
          )
          .doc(
            uid,
          )
          .get();

      List following =
          (documentSnapshot.data()! as Map<String, dynamic>)['following'];
      print(followId);

      //Unfollow
      if (following.contains(followId)) {
        await _firestore
            .collection(
              FirebaseCollectionName.users,
            )
            .doc(
              uid,
            )
            .update({
          FirebaseFieldName.following: FieldValue.arrayRemove(
            [followId],
          )
        });
        await _firestore
            .collection(
              FirebaseCollectionName.users,
            )
            .doc(
              followId,
            )
            .update({
          FirebaseFieldName.followers: FieldValue.arrayRemove(
            [uid],
          )
        });
      } else {
        //Follow
        await _firestore
            .collection(
              FirebaseCollectionName.users,
            )
            .doc(
              uid,
            )
            .update({
          FirebaseFieldName.following: FieldValue.arrayUnion(
            [followId],
          )
        });
        await _firestore
            .collection(
              FirebaseCollectionName.users,
            )
            .doc(
              followId,
            )
            .update({
          FirebaseFieldName.followers: FieldValue.arrayUnion(
            [uid],
          )
        });
      }
    } catch (e) {}
  }
}
