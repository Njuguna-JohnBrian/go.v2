import 'package:flutter/material.dart';
import 'package:go/screens/profile/profile_barrel.dart' show ProfileBody;


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfileBody(),
    );
  }
}
