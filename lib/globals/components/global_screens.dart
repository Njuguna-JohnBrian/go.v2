import 'package:flutter/material.dart';
import "package:go/screens/screens_barrel.dart"
    show ProfileScreen, TripDetailsScreen;

List<Widget> goPages = <Widget>[
  TripDetailsScreen(),
  const ProfileScreen(),

  Container(
    color: Colors.greenAccent,
  ),
  // const ProfileScreen(),
  Container(
    color: Colors.greenAccent,
  ),
];
