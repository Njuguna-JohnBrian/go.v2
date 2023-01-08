import 'dart:async' show StreamController;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go/backend/trips/trips_model.dart';

final userTripsProvider = StreamProvider.autoDispose<Iterable<TripsModel>>(
  (ref) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final controller = StreamController<Iterable<TripsModel>>();

    controller.onListen = () {
      controller.sink.add([]);
    };
    final sub = firestore
        .collection('trips')
        .orderBy(
          "startDate",
          descending: true,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final document = snapshot.docs;
        final trips = document
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => TripsModel(
                tripId: doc.id,
                json: doc.data(),
              ),
            );

        controller.sink.add(trips);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
