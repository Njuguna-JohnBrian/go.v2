import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/backend/userinfo/backend_firestore.dart';
import 'package:go/globals/components/global_snackbar.dart';
import 'package:go/models/userdata/users_data.dart';
import 'package:go/screens/profile/components/following_followers/follow_button.dart';
import 'package:go/theme/go_theme.dart';

class AllUsersBody extends StatefulWidget {
  final AllUsersDataModel user;
  final List<dynamic> followers;
  final List<dynamic> following;
  const AllUsersBody({
    Key? key,
    required this.user,
    required this.followers,
    required this.following,
  }) : super(key: key);

  @override
  State<AllUsersBody> createState() => _AllUsersBodyState();
}

class _AllUsersBodyState extends State<AllUsersBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isFollowing = widget.following.contains(widget.user.userId);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.redAccent,
          border: Border.all(
            color: Colors.black.withOpacity(
              0.25,
            ),
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: GoTheme.mainColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  image: NetworkImage(
                    widget.user.profilePhoto,
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
                  widget.user.displayName,
                  style: GoTheme.lightTextTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                FollowButton(
                  actionText: isFollowing ? 'Unfollow' : "Follow",
                  foreColor: isFollowing ? Colors.black : Colors.white,
                  backColor:
                      isFollowing ? Colors.grey.shade200 : GoTheme.mainColor,
                  function: () async {
                    await FirestoreMethods().followUnfollowUser(
                      FirebaseAuth.instance.currentUser!.uid,
                      widget.user.userId,
                    );
                    if (!mounted) return;

                    showSnackBar(
                      context,
                      "Success",
                      "You ${!isFollowing ? "followed" : "unfollowed"} ${widget.user.displayName}",
                      GoTheme.mainSuccess,
                      GoTheme.mainLightSuccess,
                      GoTheme.mainLightSuccess,
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
