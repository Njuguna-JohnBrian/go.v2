import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/globals/globals_barrel.dart';
import 'package:go/theme/go_theme.dart';

import '../../../backend/backend_firestore.dart';
import 'following_followers/follow_button.dart';

class ProfileFollow extends StatefulWidget {
  const ProfileFollow({Key? key}) : super(key: key);

  @override
  State<ProfileFollow> createState() => _ProfileFollowState();
}

class _ProfileFollowState extends State<ProfileFollow> {
  bool isLoading = false;
  var userData = {};
  var userFollowing = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData({bool? loadingStatus}) async {
    setState(() {
      isLoading = loadingStatus ?? true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      userData = userSnap.data()!;
      userFollowing = userData["following"];
      setState(() {
        isLoading = loadingStatus ?? false;
      });
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? GlobalSpinner(context: context)
        : Scaffold(
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
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where(
                    'uid',
                    isNotEqualTo: FirebaseAuth.instance.currentUser?.uid,
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return GlobalSpinner(context: context);
                }

                return GridView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    bool isThere = userFollowing
                        .contains(snapshot.data.docs[index]['uid']);
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
                                      snapshot.data.docs[index]['photo_url']),
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
                                  snapshot.data.docs[index]['display_name'],
                                  style: GoTheme.lightTextTheme.headline3,
                                  textAlign: TextAlign.center,
                                ),
                                FollowButton(
                                  actionText: isThere ? 'Unfollow' : "Follow",
                                  function: () async {
                                    await FirestoreMethods().followUnfollowUser(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      snapshot.data.docs[index]['uid'],
                                    );
                                    await getData(loadingStatus: false);
                                    if (!mounted) return;
                                    showSnackBar(
                                      context,
                                      "Success",
                                      "You ${!isThere ? "followed" : "unfollowed"} ${snapshot.data.docs[index]['display_name']}",
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
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                );
              },
            ),
          );
  }
}
