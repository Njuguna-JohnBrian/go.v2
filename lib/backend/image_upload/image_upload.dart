import 'dart:typed_data';

import 'package:uuid/uuid.dart' show Uuid;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageStorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Add image to firebase storage
  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isTripCover,
  ) async {
    Reference ref = _firebaseStorage.ref().child(childName).child(
          _firebaseAuth.currentUser!.uid,
        );
    if (isTripCover) {
      String tripCoverId = const Uuid().v1();
      ref = ref.child(tripCoverId);
    }

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
