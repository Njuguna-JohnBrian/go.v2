import 'dart:async' show StreamController;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go/models/userdata/users_data.dart';
import 'package:go/state/providers/auth/user_id_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final followersProvider =
    StreamProvider.autoDispose<Iterable<AllUsersDataModel>>(
  (ref) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userId = ref.watch(userIdProvider);

    final controller = StreamController<Iterable<AllUsersDataModel>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = firestore
        .collection("users")
        .where(
          'uid',
          isNotEqualTo: userId,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final document = snapshot.docs;

        final users = document
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => AllUsersDataModel(
                userId: doc.id,
                json: doc.data(),
              ),
            );
        controller.sink.add(users);
      },
    );
    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
