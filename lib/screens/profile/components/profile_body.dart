import 'package:flutter/material.dart';
import 'package:go/screens/profile/profile_barrel.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      CustomScrollView(
      slivers: [
        ProfileSliverAppBar(),
        // ProfileSliverBody()
      ],
    );
  }
}
