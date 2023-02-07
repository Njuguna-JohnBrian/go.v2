import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/backend/userinfo/backend_firestore.dart';
import 'package:go/globals/globals_barrel.dart' show GlobalSpinner;
import 'package:go/theme/go_theme.dart';

class FollowScreen extends StatefulWidget {
  final List following;
  final List followers;
  final int currentIndex;
  const FollowScreen({
    Key? key,
    required this.following,
    required this.followers,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  var userFollowingData = [];
  var userFollowersData = [];
  late Future getFollowing;
  late Future getFollowers;

  @override
  void initState() {
    getFollowing = getFollowingData();
    getFollowers = getFollowersData();
    super.initState();
  }

  Future getFollowingData() async {
    final data = widget.following;

    var users = await Future.wait(data.map((id) {
      return FirebaseFirestore.instance.collection("users").doc(id).get();
    }));

    userFollowingData = [
      ...userFollowingData,
      ...users,
    ].toList();

    // for (var id in data) {
    //   var userSnap =
    //       await FirebaseFirestore.instance.collection("users").doc(id).get();
    //
    //   userFollowingData.add(userSnap.data());
    // }
    return userFollowingData;
  }

  Future getFollowersData() async {
    final data = widget.followers;
    for (var id in data) {
      var userSnap =
          await FirebaseFirestore.instance.collection("users").doc(id).get();

      userFollowersData.add(userSnap.data());
    }
    return userFollowersData;
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> profileTabs = <Tab>[
      Tab(
        child: Text(
          "${widget.following.length} following",
        ),
      ),
      Tab(
        child: Text(
          "${widget.followers.length} ${widget.followers.length > 1 ? 'followers' : 'follower'}",
        ),
      )
    ];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: size.height * 0.05,
            color: GoTheme.mainColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "John Brian",
          style: GoTheme.lightTextTheme.headline6?.copyWith(
            color: GoTheme.mainColor,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: widget.currentIndex,
        animationDuration: const Duration(
          microseconds: 500,
        ),
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: GoTheme.mainLigtColor,
              labelColor: GoTheme.mainColor,
              labelStyle: GoTheme.lightTextTheme.headline6,
              indicatorColor: GoTheme.mainLigtColor,
              tabs: profileTabs,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: FutureBuilder(
                      future: getFollowing,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return buildFollowView(
                            context,
                            snapshot,
                            userFollowingData,
                            "Unfollow",
                          );
                        } else {
                          return GlobalSpinner(context: context);
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: FutureBuilder(
                      future: getFollowers,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return buildFollowView(
                            context,
                            snapshot,
                            userFollowersData,
                            "Remove",
                          );
                        } else {
                          return GlobalSpinner(context: context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFollowView(BuildContext context, AsyncSnapshot<dynamic> snapshot,
      List<dynamic> data, String action) {
    return ListView.builder(
      itemCount: data.length,
      itemExtent: 80,
      itemBuilder: (context, index) {
        String photoUrl = snapshot.data[index]["photo_url"];
        String displayName = snapshot.data[index]["display_name"];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: GoTheme.mainColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  image: NetworkImage(
                    photoUrl,
                  ),
                  filterQuality: FilterQuality.medium,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(displayName,
                style: GoTheme.lightTextTheme.headline3
                    ?.copyWith(overflow: TextOverflow.fade)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black,
                minimumSize: const Size(
                  100,
                  35,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
              ),
              onPressed: () async {
                await FirestoreMethods().followUnfollowUser(
                  FirebaseAuth.instance.currentUser!.uid,
                  snapshot.data[index]["uid"],
                );
              },
              child: Text(
                action,
              ),
            )
          ],
        );
      },
    );
  }
}
