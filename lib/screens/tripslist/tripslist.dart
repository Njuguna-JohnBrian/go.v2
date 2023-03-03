import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/animations/animations_barrel.dart';
import 'package:go/screens/screens_barrel.dart';
import 'package:go/theme/go_theme.dart';

class TripsListScreen extends StatelessWidget {
  const TripsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("trips")
          .where(
            "uid",
            isNotEqualTo: FirebaseAuth.instance.currentUser?.uid,
          )
          .snapshots(),
      builder: (
        context,
        AsyncSnapshot snapshot,
      ) {
        return (snapshot.data == null || snapshot.data.docs.length == 0)
            ? const EmptyContentAnimationView()
            : (snapshot.connectionState == ConnectionState.waiting)
                ? LinearProgressIndicator(
                    color: GoTheme.mainColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  )
                : buildList(
                    context: context,
                    snap: snapshot,
                    size: size,
                  );
      },
    ));
  }

  Widget buildList(
      {required BuildContext context, required snap, required Size size}) {
    return ListView.builder(
      itemCount: snap.data.docs.length,
      itemBuilder: (context, index) {
        final data = snap.data.docs[index].data();
        return SizedBox(
          height: index == 0 ? size.height * 0.90 : size.height,
          child: TripDetailsScreen(
            tripTitle: data['tripTitle'],
            tripSummary: data['tripSummary'],
            startLocation: data["startLocation"],
            tripCover: data['tripUrl'],
            likes: data['likes'],
            userId: data["uid"],
            tripId: data['tripId'],
            showAppBar: false,
          ),
        );
      },
    );
  }
}
