import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/animations/animations_barrel.dart';
import 'package:go/globals/globals_barrel.dart';
import 'package:go/globals/string_extension.dart';
import 'package:go/models/models_barrel.dart';
import 'package:go/screens/screens_barrel.dart';
import 'package:go/theme/go_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utils/strings.dart';

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
          elevation: 0,
          expandedHeight: size.height * 0.35,
          backgroundColor: Colors.transparent,
          leading: SvgPicture.asset(
            GlobalAssets.logoSvg,
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
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                color: GoTheme.mainColor,
                size: 35,
              ),
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ProfileStrings.worldMap,
                  ),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(
                        2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: CachedNetworkImageProvider(
                            userData.profilePhoto,
                          ),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                    ),
                    Text(
                      userData.displayName,
                      style: GoTheme.darkTextTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FollowScreen(
                                  following: userData.following,
                                  followers: userData.followers,
                                  currentIndex: 0,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.black.withOpacity(
                                  0.4,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            alignment: Alignment.center,
                            width: 80,
                            height: 30,
                            child: Text(
                              "${userData.following.length} following",
                              style: GoTheme.darkTextTheme.bodyText1?.copyWith(
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FollowScreen(
                                  following: userData.following,
                                  followers: userData.followers,
                                  currentIndex: 1,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.black.withOpacity(
                                  0.4,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            alignment: Alignment.center,
                            width: 80,
                            height: 30,
                            child: Text(
                              "${userData.followers.length} followers",
                              style: GoTheme.darkTextTheme.bodyText1?.copyWith(
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
                                color: Colors.black.withOpacity(
                                  0.5,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(
                                30,
                              ),
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
        const UserActivity()
      ],
    );
  }
}

class UserActivity extends StatefulWidget {
  const UserActivity({Key? key}) : super(key: key);

  @override
  State<UserActivity> createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "Trips",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Insights",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              buildTabView(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabView(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      child: TabBarView(
        children: [
          Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(
                10,
              ),
              children: [
                Container(
                  height: size.height * 0.25,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: const NetworkImage(
                        "https://tinyurl.com/2s3mv3mv",
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.4),
                        BlendMode.modulate,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 10,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Now Travelling".toCapitalized(),
                            style: GoTheme.darkTextTheme.bodyText1,
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 70,
                        child: Text(
                          "John",
                          style: GoTheme.darkTextTheme.bodyText1,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Header",
                              style: GoTheme.darkTextTheme.bodyText1,
                            ),
                            Text(
                              "Title",
                              style: GoTheme.darkTextTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Header",
                              style: GoTheme.darkTextTheme.bodyText1,
                            ),
                            Text(
                              "Title",
                              style: GoTheme.darkTextTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Header",
                              style: GoTheme.darkTextTheme.bodyText1,
                            ),
                            Text(
                              "Title",
                              style: GoTheme.darkTextTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Header",
                              style: GoTheme.darkTextTheme.bodyText1,
                            ),
                            Text(
                              "Title",
                              style: GoTheme.darkTextTheme.bodyText1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.yellow,
            child: const ActiveView(),
          )
        ],
      ),
    );
  }
}
