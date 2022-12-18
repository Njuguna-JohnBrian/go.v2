import 'package:flutter/material.dart';

import 'package:go/theme/go_theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class TripsLocationSection extends StatefulWidget {
  const TripsLocationSection({
    Key? key,
  }) : super(key: key);

  @override
  State<TripsLocationSection> createState() => _TripsLocationSectionState();
}

class _TripsLocationSectionState extends State<TripsLocationSection> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final TextEditingController locationController = TextEditingController();
  bool appHasLocationPermission = false;
  bool isGlobalLocationEnabled = false;
  late String currentAddress;

  @override
  void initState() {
    _checkLocationOnInit();
    super.initState();
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: Colors.grey,
          size: 30,
        ),
        SizedBox(
          width: size.width * 0.08,
        ),
        SizedBox(
          width: size.width * 0.45,
          child: TextFormField(
            controller: locationController,
            autovalidateMode: AutovalidateMode.always,
            validator: ((value) {
              if (value!.isEmpty) {
                return "Please click to enable location";
              } else {
                return null;
              }
            }),
            onTap: () {},
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Travel Tracker',
              labelStyle: GoTheme.lightTextTheme.headline6,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.16,
        ),
        Switch(
          value: isGlobalLocationEnabled,
          onChanged: (value) {
            _handlePermission();
          },
        ),
      ],
    );
  }

  _checkLocationOnInit() async {
    bool globalLocationServiceEnabled =
        await _geolocatorPlatform.isLocationServiceEnabled();
    setState(() {
      isGlobalLocationEnabled = globalLocationServiceEnabled;
    });

    if (globalLocationServiceEnabled == true) {
      await _getCurrentLocation();
    }
  }

  _handlePermission() async {
    bool globalLocationServiceEnabled =
        await _geolocatorPlatform.isLocationServiceEnabled();
    LocationPermission appLocationServiceEnabled =
        await _geolocatorPlatform.checkPermission();
    if (globalLocationServiceEnabled == false) {
      final settingsResult = await _openAppLocationSettings();
      await _getCurrentLocation();
      setState(() {
        isGlobalLocationEnabled = settingsResult;
      });
    }

    if (appLocationServiceEnabled == LocationPermission.denied) {
      await _enableAppLocationAccess();
    } else if (appLocationServiceEnabled == LocationPermission.deniedForever) {
      await _enableAppLocationAccess();
    }
  }

  Future<bool> _openAppLocationSettings() async {
    bool isEnabled = await _geolocatorPlatform.openLocationSettings();
    return isEnabled;
  }

  Future<LocationPermission> _enableAppLocationAccess() async {
    final appAccessEnabled = await _geolocatorPlatform.requestPermission();

    return appAccessEnabled;
  }

  _getCurrentLocation() async {
    await _handlePermission();
    final position = await _geolocatorPlatform.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    setState(() {
      currentAddress = "${place.locality}, ${place.country}";
      locationController.text = currentAddress;
    });
  }
}
