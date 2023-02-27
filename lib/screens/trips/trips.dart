import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go/backend/backend_barrel.dart';
import 'package:go/screens/screens_barrel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:go/globals/globals_barrel.dart';
import 'package:go/theme/go_theme.dart';
import 'package:quickalert/quickalert.dart';
import 'utils/strings.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _tripsFormKey = GlobalKey<FormState>();
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
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _privacyController = TextEditingController(
    text: TripStrings.publicListTitle,
  );

  Uint8List? coverImage;
  double? _startLongitude;
  double? _startLatitude;
  bool isGlobalLocationEnabled = false;
  bool isLoading = false;

  @override
  void initState() {
    _checkLocationOnInit();
    super.initState();
  }

  Future<void> addTrip() async {
    try {
      setState(() {
        isLoading = true;
      });
      String result = await TripFirebaseMethods().uploadTrip(
        FirebaseAuth.instance.currentUser!.uid,
        _tripNameController.text,
        _tripDescriptionController.text,
        _privacyController.text,
        _locationController.text,
        _startDateController.text,
        _endDateController.text,
        _startLongitude!,
        _startLatitude!,
        coverImage!,
        FirebaseAuth.instance.currentUser!.photoURL,
      );

      setState(() {
        isLoading = false;
      });

      if (result.contains(TripStrings.success)) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          barrierDismissible: true,
          confirmBtnColor: GoTheme.mainSuccess,
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
            _tripsFormKey.currentState?.reset();
            if (!mounted) {}
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: TripStrings.failed,
        text: TripStrings.retry,
        barrierDismissible: false,
        confirmBtnColor: const Color(0xFFC4144D),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? GlobalSpinner(context: context)
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                TripStrings.appTitle,
                style: GoTheme.lightTextTheme.headline6?.copyWith(
                  color: GoTheme.mainColor,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: GoTheme.mainColor,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.045,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (_tripsFormKey.currentState!.validate()) {
                          await addTrip();
                        }
                      },
                      child: Text(
                        TripStrings.saveAction,
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
              padding: EdgeInsets.only(
                left: size.width * 0.045,
                right: size.width * 0.045,
              ),
              child: Form(
                key: _tripsFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          buildImageSelector(
                            context: context,
                            size: size,
                          ),
                          buildPadding(
                            context: context,
                          ),
                          buildDescription(
                            context: context,
                            size: size,
                          ),
                          buildPadding(
                            context: context,
                          ),
                          buildCalendarSection(
                            context: context,
                            size: size,
                          ),
                          buildPadding(
                            context: context,
                          ),
                          buildLocationSection(
                            context: context,
                            size: size,
                          ),
                          buildPadding(
                            context: context,
                          ),
                          buildPrivacySection(
                            context: context,
                            size: size,
                          ),
                          buildPadding(
                            context: context,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget buildImageSelector({
    required BuildContext context,
    required Size size,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.01,
      ),
      child: Row(
        children: [
          coverImage == null
              ? DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(
                    10,
                  ),
                  color: Colors.grey,
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  strokeWidth: 1,
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                    ),
                    iconSize: 25,
                    color: Colors.grey,
                    onPressed: () {
                      buildImageDialog(
                        context: context,
                        size: size,
                      );
                    },
                  ),
                )
              : Container(
                  height: size.height * 0.11,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    image: DecorationImage(
                      image: MemoryImage(
                        coverImage!,
                      ),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
          SizedBox(
            width: size.width * 0.10,
          ),
          GestureDetector(
            onTap: () async {
              await buildImageDialog(
                context: context,
                size: size,
              );
            },
            child: Container(
              height: size.height * 0.04,
              width: size.width * 0.4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: coverImage != null
                      ? Colors.black.withOpacity(
                          0.4,
                        )
                      : Colors.redAccent,
                ),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Text(
                coverImage != null
                    ? TripStrings.changeCover
                    : TripStrings.uploadCover,
                style: GoTheme.darkTextTheme.bodyText1?.copyWith(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> buildImageDialog({
    required BuildContext context,
    required Size size,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            TripStrings.selectTripCover,
          ),
          titleTextStyle: GoTheme.lightTextTheme.headline6,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(
                20,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    TripStrings.takePicture,
                    style: GoTheme.lightTextTheme.headline6,
                  ),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();

                Uint8List selectedImage = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  coverImage = selectedImage;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(
                20,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.browse_gallery,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    TripStrings.selectFromGallery,
                    style: GoTheme.lightTextTheme.headline6,
                  ),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();

                Uint8List selectedImage = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  coverImage = selectedImage;
                });
              },
            ),
            Center(
              child: SimpleDialogOption(
                padding: const EdgeInsets.all(
                  20,
                ),
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    minimumSize: const Size(
                      100,
                      35,
                    ),
                  ),
                  child: Text(
                    TripStrings.cancel,
                    style: GoTheme.darkTextTheme.headline3,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildPadding({
    required BuildContext context,
  }) {
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

  Widget buildDescription({
    required BuildContext context,
    required Size size,
  }) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.title,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.12,
            ),
            SizedBox(
              width: size.width * 0.70,
              child: TextFormField(
                controller: _tripNameController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return TripStrings.provideTitle;
                  } else if (value.length < 3) {
                    return TripStrings.provideLongerTitle;
                  } else {
                    return null;
                  }
                }),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: TripStrings.tripLabel,
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: TripStrings.tripHint,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.summarize_outlined,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.12,
            ),
            SizedBox(
              width: size.width * 0.70,
              child: TextFormField(
                controller: _tripDescriptionController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return TripStrings.provideSummary;
                  } else if (value.length < 3) {
                    return TripStrings.provideLongerSummary;
                  } else {
                    return null;
                  }
                }),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: TripStrings.tripSummaryLabel,
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: TripStrings.tripSummaryHint,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildCalendarSection({
    required BuildContext context,
    required Size size,
  }) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.12,
            ),
            SizedBox(
              width: size.width * 0.70,
              child: TextFormField(
                controller: _startDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: TripStrings.tripStartLabel,
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: DateFormat("MMMM dd yyyy").format(
                    DateTime.now(),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                      DateTime.now().year + 5,
                    ),
                    helpText: TripStrings.tripStartHint,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: GoTheme.mainColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((value) {
                    if (value != null) {
                      _startDateController.text =
                          DateFormat("MMMM dd yyyy").format(
                        value,
                      );
                    }
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.today_sharp,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.12,
            ),
            SizedBox(
              width: size.width * 0.70,
              child: TextFormField(
                controller: _endDateController,
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return TripStrings.provideEndDate;
                  } else {
                    return null;
                  }
                }),
                decoration: InputDecoration(
                  labelText: TripStrings.tripEndLabel,
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: TripStrings.tripEndHint,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                      DateTime.now().year + 5,
                    ),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: GoTheme.mainColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then(
                    (value) {
                      if (value != null) {
                        _endDateController.text = DateFormat(
                          "MMMM dd yyyy",
                        ).format(
                          value,
                        );
                      }
                    },
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildLocationSection({
    required BuildContext context,
    required Size size,
  }) {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: Colors.grey,
          size: 30,
        ),
        SizedBox(
          width: size.width * 0.12,
        ),
        SizedBox(
          width: size.width * 0.55,
          child: TextFormField(
            controller: _locationController,
            autovalidateMode: AutovalidateMode.always,
            validator: ((value) {
              if (value!.isEmpty) {
                return TripStrings.enableLocation;
              } else {
                return null;
              }
            }),
            readOnly: true,
            decoration: InputDecoration(
              labelText: TripStrings.tripLocationLabel,
              labelStyle: GoTheme.lightTextTheme.headline6,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.009,
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

  Widget buildPrivacySection({
    required BuildContext context,
    required Size size,
  }) {
    return Row(
      children: [
        const Icon(
          Icons.privacy_tip_outlined,
          color: Colors.grey,
          size: 30,
        ),
        SizedBox(
          width: size.width * 0.12,
        ),
        SizedBox(
          width: size.width * 0.70,
          child: TextFormField(
            controller: _privacyController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: TripStrings.privacyLabel,
              labelStyle: GoTheme.lightTextTheme.headline6,
              hintText: TripStrings.privacyHint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      30,
                    ),
                    topRight: Radius.circular(
                      30,
                    ),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  String privacyValue = TripStrings.publicListTitle;
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      void handlePrivacyChange(String? value) {
                        setState(() {
                          privacyValue = value!;
                          _privacyController.text = value;
                        });
                      }

                      return SimpleDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          TripStrings.selectPrivacyTitle,
                        ),
                        titleTextStyle: GoTheme.lightTextTheme.headline2,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        children: [
                          SimpleDialogOption(
                            child: ListTile(
                              title: Text(
                                TripStrings.privateListTitle,
                                style: GoTheme.lightTextTheme.headline2,
                              ),
                              leading: Transform.scale(
                                scale: 1.5,
                                child: Radio(
                                  value: TripStrings.privateListTitle,
                                  groupValue: privacyValue,
                                  onChanged: handlePrivacyChange,
                                  activeColor: GoTheme.mainColor,
                                ),
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            child: ListTile(
                              title: Text(
                                TripStrings.publicListTitle,
                                style: GoTheme.lightTextTheme.headline2,
                              ),
                              leading: Transform.scale(
                                scale: 1.5,
                                child: Radio(
                                  value: TripStrings.publicListTitle,
                                  groupValue: privacyValue,
                                  onChanged: handlePrivacyChange,
                                  activeColor: GoTheme.mainColor,
                                ),
                              ),
                            ),
                          ),
                          SimpleDialogOption(
                            child: ListTile(
                              title: Text(
                                TripStrings.premiumListTitle,
                                style: GoTheme.lightTextTheme.headline2,
                              ),
                              leading: Transform.scale(
                                scale: 1.5,
                                child: Radio(
                                  value: TripStrings.premiumListTitle,
                                  groupValue: privacyValue,
                                  onChanged: handlePrivacyChange,
                                  activeColor: GoTheme.mainColor,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: SimpleDialogOption(
                              padding: const EdgeInsets.all(
                                20,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  minimumSize: const Size(
                                    150,
                                    50,
                                  ),
                                ),
                                child: Text(
                                  TripStrings.cancel,
                                  style: GoTheme.darkTextTheme.headline3,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
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

    LocationPermission applocationServiceEnabled =
        await _geolocatorPlatform.checkPermission();

    if (globalLocationServiceEnabled == false) {
      final settingsResult = await openAppLocationSettings();
      await _getCurrentLocation();

      setState(() {
        isGlobalLocationEnabled = settingsResult;
      });
    }

    if (applocationServiceEnabled == LocationPermission.denied ||
        applocationServiceEnabled == LocationPermission.deniedForever) {
      await _enableAppLocationAccess();
    }
  }

  Future<bool> openAppLocationSettings() async {
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

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks[0];

    setState(() {
      _locationController.text = "${place.locality}, ${place.country}";
      // _locationController.text = TripStrings.defaultLocation;
      _startLatitude = position.latitude;
      _startLongitude = position.longitude;
    });
  }
}
