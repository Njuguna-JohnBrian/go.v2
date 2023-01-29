import 'package:flutter/material.dart';
import 'package:go/models/models_barrel.dart';

class ProfileBody extends StatelessWidget {
  final UserDataModel userData;
  const ProfileBody({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          expandedHeight: size.height * 0.4,
          backgroundColor: Colors.transparent,

        )
      ],
    );
  }
}
