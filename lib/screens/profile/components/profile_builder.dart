import 'package:flutter/material.dart';
import 'package:go/models/userdata/userdata.dart';
import 'package:go/screens/profile/components/profile_body.dart';

class ProfileBuilder extends StatelessWidget {
  final Iterable<UserDataModel> userData;
  const ProfileBuilder({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = userData.elementAt(0);
    return ProfileBody(
      userData: user,
    );
  }
}
