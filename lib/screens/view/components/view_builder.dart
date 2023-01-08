import 'package:flutter/material.dart';
import 'package:go/backend/trips/trips_model.dart';
import 'package:go/screens/view/components/view_body.dart';

class ViewBuilder extends StatelessWidget {
  final Iterable<TripsModel> trips;
  final bool isLoggedIn;
  const ViewBuilder({
    Key? key,
    required this.trips,
    required this.isLoggedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips.elementAt(index);
        return ViewBody(
          trips: trip,
          isLoggedIn: isLoggedIn,
        );
      },
    );
  }
}
