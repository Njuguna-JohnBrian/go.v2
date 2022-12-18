import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:go/screens/trips/trips_barrel.dart';

typedef CoverImageCallback = void Function(Uint8List imageDate);

class TripsBody extends StatefulWidget {
  final TextEditingController tripNameController;
  final TextEditingController tripDescriptionController;
  final TextEditingController endDateController;
  final TextEditingController startDateController;
  final TextEditingController tripPrivacyController;
  final CoverImageCallback imageReceived;
  const TripsBody({
    Key? key,
    required this.tripNameController,
    required this.tripDescriptionController,
    required this.endDateController,
    required this.startDateController,
    required this.tripPrivacyController,
    required this.imageReceived,
  }) : super(key: key);

  @override
  State<TripsBody> createState() => _TripsBodyState();
}

class _TripsBodyState extends State<TripsBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TripsImageSection(
                onImageSelected: (image) {
                  widget.imageReceived(image);
                },
              ),
              _buildPadding(context),
              TripsDescriptionSection(
                tripNameController: widget.tripNameController,
                tripDescriptionController: widget.tripDescriptionController,
              ),
              _buildPadding(context),
              TripsCalendarSection(
                startDateController: widget.startDateController,
                endDateController: widget.endDateController,
              ),
              _buildPadding(context),
              const TripsLocationSection(),
              _buildPadding(context),
              TripsPrivacySection(
                tripPrivacyController: widget.tripPrivacyController,
              ),
            ],
          ),
        ],
      ),
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
