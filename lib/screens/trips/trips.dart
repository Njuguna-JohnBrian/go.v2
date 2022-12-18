import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go/screens/screens_barrel.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'package:go/backend/backend_barrel.dart';
import 'package:go/globals/components/global_spinner.dart';
import 'package:go/screens/trips/trips_barrel.dart';
import 'package:go/theme/go_theme.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _tripsFormKey = GlobalKey<FormState>();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _tripDescriptionController =
      TextEditingController();

  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController(
    text: DateFormat('MMMM dd yyyy').format(
      DateTime.now(),
    ),
  );
  final TextEditingController _tripPrivacyController = TextEditingController(
    text: "Public",
  );
  Uint8List? _coverImage;
  double? _longitude;
  double? _latitude;
  bool isLoading = false;

  @override
  void dispose() {
    _tripNameController.dispose();
    _tripDescriptionController.dispose();
    _endDateController.dispose();
    _startDateController.dispose();
    _tripPrivacyController.dispose();
    super.dispose();
  }

  _getCurrentLocation() async {
    final position = await _geolocatorPlatform.getCurrentPosition();

    setState(() {
      _longitude = position.longitude;
      _latitude = position.latitude;
    });
  }

  Future<void> addTrip() async {
    try {
      setState(() {
        isLoading = true;
      });
      _getCurrentLocation();
      String result = await TripFirebaseMethods().uploadTrip(
        FirebaseAuth.instance.currentUser!.uid,
        _tripNameController.text,
        _tripDescriptionController.text,
        _tripPrivacyController.text,
        _startDateController.text,
        _endDateController.text,
        _longitude!,
        _latitude!,
        _coverImage!,
        FirebaseAuth.instance.currentUser!.photoURL,
      );
      setState(() {
        isLoading = false;
      });
      if (result == "Success") {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            barrierDismissible: true,
            confirmBtnColor: GoTheme.mainSuccess,
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TripDetailsScreen(),
                ),
              );
            });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.toString() == "Null check operator used on a null value") {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Cover Image Error",
          text: "Trip Cover Image  cannot be blank",
          barrierDismissible: false,
          confirmBtnColor: const Color(0xFFC4144D),
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Failed",
          text: "Please retry",
          barrierDismissible: false,
          confirmBtnColor: const Color(0xFFC4144D),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? GlobalSpinner(context: context)
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Text(
                "New trip",
                style: GoTheme.lightTextTheme.headline6?.copyWith(
                  color: GoTheme.mainColor,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                ),
                color: GoTheme.mainColor,
                iconSize: 25,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (_tripsFormKey.currentState!.validate()) {
                          await addTrip();
                        }
                      },
                      child: Text(
                        "Save",
                        style: GoTheme.lightTextTheme.headline6?.copyWith(
                          color: GoTheme.mainColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Form(
                key: _tripsFormKey,
                child: TripsBody(
                  tripNameController: _tripNameController,
                  tripDescriptionController: _tripDescriptionController,
                  startDateController: _startDateController,
                  endDateController: _endDateController,
                  tripPrivacyController: _tripPrivacyController,
                  imageReceived: (Uint8List imageData) {
                    setState(() {
                      _coverImage = imageData;
                    });
                  },
                ),
              ),
            ),
          );
  }
}
