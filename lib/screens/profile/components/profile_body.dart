import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/animations/animations_barrel.dart';
import 'package:go/theme/go_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:go/globals/globals_barrel.dart' show GlobalAssets;

import 'package:go/models/models_barrel.dart' show UserDataModel;
import 'package:go/screens/follow/utils/strings.dart';
import 'package:go/screens/screens_barrel.dart'
    show
        FollowScreen,
        SettingsScreen,
        TripDetailsScreen,
        TripsScreen,
        UsersScreen;
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TripsScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: GoTheme.mainColor,
                size: 35,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      following: userData.following,
                      followers: userData.followers,
                    ),
                  ),
                );
              },
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
                              "${userData.following.length} ${FollowStrings.following}",
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
                              "${userData.followers.length} ${FollowStrings.followers}",
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UsersScreen(
                                  followers: userData.followers,
                                  following: userData.following,
                                ),
                              ),
                            );
                          },
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
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        ProfileStrings.trips,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Tab(
                      child: Text(
                        ProfileStrings.insights,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ],
                ),
                buildTabView(context)
              ],
            ),
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
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("trips")
                  .where(
                    "uid",
                    isEqualTo: FirebaseAuth.instance.currentUser?.uid,
                  )
                  .orderBy(
                    "createdAt",
                    descending: true,
                  )
                  .snapshots(),
              builder: (
                context,
                AsyncSnapshot snapshot,
              ) {
                return (snapshot.data == null || snapshot.data.docs.length == 0)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TripsScreen(),
                              ),
                            ),
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              minimumSize: const Size(
                                100,
                                35,
                              ),
                            ),
                            child: Text(
                              "Add Trip",
                              style: GoTheme.darkTextTheme.headline3,
                            ),
                          ),
                          const EmptyContentAnimationView(),
                        ],
                      )
                    : (snapshot.connectionState == ConnectionState.waiting)
                        ? LinearProgressIndicator(
                            color: GoTheme.mainColor,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          )
                        : buildList(
                            context: context,
                            size: size,
                            snap: snapshot,
                          );
              },
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

  Widget buildList(
      {required BuildContext context, required Size size, required snap}) {
    return ListView.separated(
      padding: const EdgeInsets.all(
        10,
      ),
      itemCount: snap.data.docs.length,
      itemBuilder: (context, index) {
        final data = snap.data.docs[index].data();

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TripDetailsScreen(
                  tripTitle: data['tripTitle'],
                  tripSummary: data['tripSummary'],
                  startLocation: data["startLocation"],
                  tripCover: data['tripUrl'],
                  likes: data['likes'],
                  userId: data["uid"],
                  tripId: data['tripId'],
                  showAppBar:true,
                ),
              ),
            );
          },
          child: Container(
            height: size.height * 0.25,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(
                  data['tripUrl'],
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
                      data["tripTitle"],
                      style: GoTheme.darkTextTheme.bodyText1,
                    )
                  ],
                ),
                Positioned(
                  bottom: 70,
                  child: SizedBox(
                    width: size.width,
                    child: Text(
                      data["tripSummary"],
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      style: GoTheme.darkTextTheme.bodyText1,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Start Date",
                        style: GoTheme.darkTextTheme.bodyText1,
                      ),
                      Text(
                        data["startDate"],
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
                        "End Date",
                        style: GoTheme.darkTextTheme.bodyText1,
                      ),
                      Text(
                        data["endDate"],
                        style: GoTheme.darkTextTheme.bodyText1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => SizedBox(
        height: size.height * 0.015,
      ),
    );
  }
}
