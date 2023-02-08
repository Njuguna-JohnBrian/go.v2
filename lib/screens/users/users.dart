import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/backend/userinfo/backend_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:go/animations/animations_barrel.dart'
    show EmptyContentAnimationView, ErrorAnimationView, LoadingAnimationView;

import 'package:go/models/userdata/users_data.dart' show AllUsersDataModel;
import 'package:go/state/providers/users/users_provider.dart';
import 'package:go/theme/go_theme.dart';
import 'utils/strings.dart';

class UsersScreen extends ConsumerWidget {
  final List<dynamic> followers;
  final List<dynamic> following;
  const UsersScreen({
    Key? key,
    required this.followers,
    required this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final users = ref.watch(allUsersProvider);

    return RefreshIndicator(
      backgroundColor: GoTheme.mainColor,
      color: Colors.white,
      child: users.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(
              child: EmptyContentAnimationView(),
            );
          } else {
            return buildScaffold(
              context,
              size,
              users,
              following,
              followers,
            );
          }
        },
        error: (error, stackTrace) {
          return const Center(
            child: ErrorAnimationView(),
          );
        },
        loading: () {
          return const Center(
            child: LoadingAnimationView(),
          );
        },
      ),
      onRefresh: () {
        ref.refresh(allUsersProvider);
        return Future.delayed(
          const Duration(
            seconds: 3,
          ),
        );
      },
    );
  }

  Widget buildScaffold(
    BuildContext context,
    Size size,
    Iterable<AllUsersDataModel> usersData,
    List<dynamic> following,
    List<dynamic> followers,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          UsersStrings.title,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: GoTheme.mainColor,
            size: 35,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: usersData.length,
        itemBuilder: (context, index) {
          return buildUsersBody(
            context,
            size,
            usersData.elementAt(index),
            following,
            followers,
          );
        },
      ),
    );
  }

  Widget buildUsersBody(
    BuildContext context,
    Size size,
    AllUsersDataModel user,
    List<dynamic> following,
    List<dynamic> followers,
  ) {
    bool isFollowing = following.contains(
      user.userId,
    );
    return Padding(
      padding: const EdgeInsets.all(
        8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: GoTheme.mainColor,
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                50,
              ),
              child: Image(
                image: CachedNetworkImageProvider(
                  user.profilePhoto,
                ),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                user.displayName,
                style: GoTheme.lightTextTheme.headline3,
                textAlign: TextAlign.center,
              ),
              buildFollowButton(
                context: context,
                actionText: isFollowing ? "Unfollow" : "Follow",
                function: () async {
                  await FirestoreMethods().followUnfollowUser(
                    FirebaseAuth.instance.currentUser!.uid,
                    user.userId,
                  );
                },
                foreColor: isFollowing ? Colors.black : Colors.white,
                backColor:
                    isFollowing ? Colors.grey.shade200 : GoTheme.mainColor,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildFollowButton({
    required BuildContext context,
    required String actionText,
    required Function() function,
    bool? isFollowing,
    bool? isFollowers,
    Color? backColor,
    Color? foreColor,
  }) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: backColor ?? Colors.grey.shade200,
        foregroundColor: foreColor ?? Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        minimumSize: const Size(
          100,
          35,
        ),
      ),
      child: Text(
        actionText,
      ),
    );
  }
}
