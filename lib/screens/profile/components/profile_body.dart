import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/globals/components/global_spinner.dart';
import 'package:go/screens/profile/components/profile_follow.dart';
import 'package:go/screens/profile/profile_barrel.dart';
import 'package:go/screens/screens_barrel.dart';

import '../../../globals/global_assets.dart';
import '../../../theme/go_theme.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  var userData = {};
  bool isLoading = false;
  int followers = 0;
  int following = 0;
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
      following = userData['following'].length;
      followers = userData['followers'].length;
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? GlobalSpinner(context: context)
        : CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                expandedHeight: size.height * 0.4,
                backgroundColor: Colors.transparent,
                leading: SvgPicture.asset(
                  GlobalAssets.logoSvg,
                  height: 100,
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: GoTheme.mainColor,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.settings,
                      color: GoTheme.mainColor,
                      size: 35,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ProfileAssets.worldMap),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                image: NetworkImage(userData['photo_url']),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.medium,
                              ),
                            ),
                          ),
                          Text(
                            userData['display_name'],
                            style: GoTheme.darkTextTheme.bodyText1,
                          ),
                          Text(
                            "Nyeri, Kenya",
                            style: GoTheme.darkTextTheme.bodyText1?.copyWith(
                              color: Colors.grey[900],
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FollowingFollowersScreen(
                                        userName: userData['display_name'],
                                        following: following,
                                        followers: followers,
                                        currentIndex: 0,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  width: 80,
                                  height: 30,
                                  child: Text(
                                    "$following following",
                                    style: GoTheme.darkTextTheme.bodyText1
                                        ?.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FollowingFollowersScreen(
                                        userName: userData['display_name'],
                                        following: following,
                                        followers: followers,
                                        currentIndex: 1,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  width: 80,
                                  height: 30,
                                  child: Text(
                                    "$followers followers",
                                    style: GoTheme.darkTextTheme.bodyText1
                                        ?.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileFollow(),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                  child: const Icon(
                                    Icons.person_add_alt_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const ProfileSliverBody(),
            ],
          );
  }
}
