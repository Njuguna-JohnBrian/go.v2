import 'package:flutter/material.dart';
import "package:go/screens/screens_barrel.dart"
    show ProfileScreen, TripsListScreen;

List<Widget> goPages = <Widget>[
  const TripsListScreen(),
  Container(
    color: Colors.greenAccent,
  ),
  Container(
    color: Colors.greenAccent,
  ),
  const ProfileScreen(),
];
