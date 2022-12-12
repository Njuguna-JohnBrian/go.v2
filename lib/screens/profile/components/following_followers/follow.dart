import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class FollowingFollowersScreen extends StatefulWidget {
  final String userName;
  final int following;
  final int followers;
  final int currentIndex;
  const FollowingFollowersScreen({
    Key? key,
    required this.userName,
    required this.following,
    required this.followers,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<FollowingFollowersScreen> createState() =>
      _FollowingFollowersScreenState();
}

class _FollowingFollowersScreenState extends State<FollowingFollowersScreen> {
  bool isLoading = false;
  var userData = {};
  bool isFollowing = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      userData = userSnap.data()!;
      isFollowing = userSnap.data()!["followers"].contains(
            FirebaseAuth.instance.currentUser!.uid,
          );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<Tab> profileTabs = <Tab>[
      Tab(
        child: Text(
          "${widget.following} following",
        ),
      ),
      Tab(
        child: Text(
          "${widget.followers} followers",
        ),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          widget.userName,
          style: GoTheme.lightTextTheme.headline6?.copyWith(
            color: GoTheme.mainColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: widget.currentIndex,
        animationDuration: const Duration(microseconds: 500),
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
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  child: const Image(
                                    image: NetworkImage(
                                        "https://tinyurl.com/kufs4ucf"),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.medium,
                                  ),
                                ),
                              ),
                              Text(
                                "John Brian Ngugi",
                                style: GoTheme.lightTextTheme.headline3,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size(100, 35),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                ),
                                child: const Text("Following"),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  child: const Image(
                                    image: NetworkImage(
                                        "https://tinyurl.com/kufs4ucf"),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.medium,
                                  ),
                                ),
                              ),
                              Text(
                                "John Brian Ngugi",
                                style: GoTheme.lightTextTheme.headline3,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size(100, 35),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                ),
                                child: const Text("Remove"),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
