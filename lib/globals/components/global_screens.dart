import 'package:flutter/material.dart';
import "package:go/screens/screens_barrel.dart"
    show ProfileScreen, FollowScreen;

List<Widget> goPages = <Widget>[
  const FollowScreen(),
  const ProfileScreen(),
  Container(
    color: Colors.greenAccent,
  ),
  // const ProfileScreen(),
  Container(
    color: Colors.greenAccent,
  ),
];
