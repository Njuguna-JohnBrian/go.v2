import 'package:flutter/material.dart';
import "package:go/screens/screens_barrel.dart"
    show ProfileScreen, SettingsScreen;

List<Widget> goPages = <Widget>[
  const SettingsScreen(),
  const ProfileScreen(),
  Container(
    color: Colors.greenAccent,
  ),
  // const ProfileScreen(),
  Container(
    color: Colors.greenAccent,
  ),
];
