import 'package:flutter/material.dart';
import "package:go/screens/screens_barrel.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/providers/auth/is_logged_in_provider.dart';
import '../../state/providers/location/location_state_provider.dart';

List<Widget> goPages = <Widget>[
  const ViewScreen(),
  Container(
    color: Colors.redAccent,
  ),
  Container(
    color: Colors.greenAccent,
  ),
  const ProfileScreen(),
];
