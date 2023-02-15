import 'package:flutter/foundation.dart' show immutable;

@immutable
class TripStrings {
  static const appTitle = "New trip";
  static const saveAction = "Save";

  static const success = "Success";
  static const failed = "Failed";
  static const retry = "Please retry";

  static const changeCover = "Change cover photo";
  static const uploadCover = "Upload cover photo";

  static const selectTripCover = "Select Trip Cover Photo";
  static const takePicture = "Take a picture";
  static const selectFromGallery = "Select from gallery";
  static const cancel = "Cancel";

  static const tripLabel = "Trip Name/Title";
  static const tripHint = "e.g African Road Trip";

  static const tripSummaryLabel = "Trip Summary";
  static const tripSummaryHint =
      "e.g An awesome road trip through the desserts on Africa with my family";

  static const tripStartLabel = "Start Date";
  static const tripStartHint = "Select start date";

  static const tripEndLabel = "End Date";
  static const tripEndHint = "End Date";

  static const tripLocationLabel = "Travel Tracker";
  static const defaultLocation = "Nyeri, Kenya";

  static const selectPrivacyTitle = "Select who can see your trip";
  static const privateListTitle = "Private";
  static const publicListTitle = "Public";
  static const premiumListTitle = "Premium";
  static const privacyLabel = "Type of trip";
  static const privacyHint = "Select to define who sees this trip";



  //Errors
  static const provideTitle = "Please provide trip name/title";
  static const provideLongerTitle = "Please provide a longer trip name";

  static const provideSummary = "Please provide a trip summary";
  static const provideLongerSummary = "Please provide a longer trip summary";

  static const provideEndDate = "Please provide an end date";

  static const enableLocation = "Please click to enable location";

  const TripStrings._();
}
