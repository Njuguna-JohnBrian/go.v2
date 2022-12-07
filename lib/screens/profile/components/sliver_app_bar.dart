import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/theme/go_theme.dart';

import 'package:go/globals/global_assets.dart';
import 'package:go/screens/profile/profile_barrel.dart';

import '../../../backend/constants/constants_firebase_collection.dart';

class ProfileSliverAppBar extends StatefulWidget {
  const ProfileSliverAppBar({Key? key}) : super(key: key);

  @override
  State<ProfileSliverAppBar> createState() => _ProfileSliverAppBarState();
}

class _ProfileSliverAppBarState extends State<ProfileSliverAppBar> {
  var userData = {};
  bool isLoading = false;

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
          .collection(FirebaseCollectionName.users)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      userData = userSnap.data()!;

      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverAppBar(
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
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
            color: GoTheme.mainColor,
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
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.transparent,
                  )
                : Column(
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
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              width: 70,
                              height: 20,
                              child: Text(
                                "0 following",
                                style:
                                    GoTheme.darkTextTheme.bodyText1?.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              width: 70,
                              height: 20,
                              child: Text(
                                "0 followers",
                                style:
                                    GoTheme.darkTextTheme.bodyText1?.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              width: 20,
                              height: 20,
                              child: const Icon(
                                Icons.person_add_alt_outlined,
                                color: Colors.white,
                                size: 15,
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
    );
  }
}
