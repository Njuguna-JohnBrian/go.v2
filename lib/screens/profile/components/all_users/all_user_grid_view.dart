import 'package:flutter/material.dart';
import 'package:go/models/userdata/users_data.dart';
import 'package:go/theme/go_theme.dart';

import 'all_users_body.dart';

class AllUsersGridView extends StatelessWidget {
  final Iterable<AllUsersDataModel> usersData;
  final List<dynamic> followers;
  final List<dynamic> following;
  const AllUsersGridView({
    Key? key,
    required this.usersData,
    required this.followers,
    required this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover gO users"),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: GoTheme.mainColor,
            size: 40,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: usersData.length,
        itemBuilder: (context, index) {
          final user = usersData.elementAt(index);
          return AllUsersBody(
            user: user,
            followers: followers,
            following: following,
          );
        },
      ),
    );
  }
}
