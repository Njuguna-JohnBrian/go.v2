import 'package:flutter/material.dart';
import 'package:go/animations/anims/empty_content_animation_view.dart';
import 'package:go/animations/anims/error_animation_view.dart';
import 'package:go/animations/anims/loading_animation_view.dart';
import 'package:go/models/userdata/userdata.dart';
import 'package:go/state/providers/userdata/userdata_provider.dart';
import 'package:go/state/providers/users/users_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'all_user_grid_view.dart';

class UsersViewScreen extends ConsumerWidget {
  final UserDataModel userData;
  const UsersViewScreen({
    required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(allUsersProvider);
    final followers = userData.followers;
    final following = userData.following;
    return RefreshIndicator(
      child: users.when(
        data: (users) {
          if (users.isEmpty) {
            return const EmptyContentAnimationView();
          } else {
            return AllUsersGridView(
              usersData: users,
              followers: followers,
              following: following,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
      onRefresh: () {
        ref.refresh(allUsersProvider);
        ref.refresh(userDataProvider);
        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
    );
  }
}
