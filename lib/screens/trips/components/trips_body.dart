import 'package:flutter/material.dart';
import 'package:go/screens/trips/trips_barrel.dart';

class TripsBody extends StatelessWidget {
  const TripsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const TripsImageSection(),
            _buildPadding(context),
            const TripsDescriptionSection(),
            _buildPadding(context),
            const TripsCalendarSection(),
            _buildPadding(context),
            const TripsLocationSection(),
            _buildPadding(context),
            const TripsPrivacySection(),
          ],
        ),
      ],
    );
  }

  Widget _buildPadding(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 30.0,
        bottom: 30.0,
      ),
      child: Divider(
        thickness: 2,
      ),
    );
  }
}
