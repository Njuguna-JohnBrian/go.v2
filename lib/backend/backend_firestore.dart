import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go/backend/constants/backend_constants_barrel.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getUserData() async {
    try {
      final userData = await _firestore
          .collection(FirebaseCollectionName.users)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      return userData.data()!;
    } catch (e) {}
  }
}
