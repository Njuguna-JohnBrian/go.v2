import 'package:flutter/material.dart';
import "package:go/screens/screens_barrel.dart"
    show ProfileScreen, FollowScreen;

List<Widget> goPages = <Widget>[
  const ProfileScreen(),
  const FollowScreen(),
  Container(
    color: Colors.greenAccent,
  ),
  // const ProfileScreen(),
  Container(
    color: Colors.greenAccent,
  ),
];
