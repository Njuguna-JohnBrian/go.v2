import 'dart:async' show StreamController;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go/models/userdata/userdata.dart';
import 'package:go/models/userdata/userdata_keys.dart';
import 'package:go/state/providers/auth/user_id_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userDataProvider = StreamProvider.autoDispose<Iterable<UserDataModel>>(
  (ref) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userId = ref.watch(userIdProvider);

    final controller = StreamController<Iterable<UserDataModel>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = firestore
        .collection("users")
        .where(UserDataKeys.userId, isEqualTo: userId)
        .snapshots()
        .listen(
      (snapshot) {
        final document = snapshot.docs;

        final userData = document
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => UserDataModel(
                userId: doc.id,
                json: doc.data(),
              ),
            );

        controller.sink.add(userData);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
