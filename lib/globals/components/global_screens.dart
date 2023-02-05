import 'package:flutter/material.dart';
import "package:go/screens/screens_barrel.dart" show ProfileScreen;

List<Widget> goPages = <Widget>[
  const ProfileScreen(),
  Container(
    color: Colors.redAccent,
  ),
  Container(
    color: Colors.greenAccent,
  ),
  // const ProfileScreen(),
  Container(
    color: Colors.greenAccent,
  ),
];
