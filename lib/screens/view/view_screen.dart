import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/globals/components/global_spinner.dart';
import 'package:go/screens/comments/comments.dart';
import 'package:go/screens/login/login.dart';
import 'package:go/theme/go_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../state/providers/location/location_state_provider.dart';
import 'package:go/globals/string_extension.dart';

import '../maps/maps.dart';

class ViewScreen extends ConsumerStatefulWidget {
  const ViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ViewScreenState();
}

class _ViewScreenState extends ConsumerState<ViewScreen> {
  bool isLoggedIn = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getUserId();
    ref.read(locationStateProvider.notifier).getLocation();
  }

  getUserId() {
    if (_firebaseAuth.currentUser?.uid != null) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // bool isLoggedIn = ref.watch(isLoggedInProvider);

    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: false,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   iconTheme: const IconThemeData(
      //     color: GoTheme.mainColor,
      //   ),
      //   leading: SvgPicture.asset(
      //     'assets/svgs/logo.svg',
      //     height: 50,
      //   ),
      // ),
      // endDrawer: ViewDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('trips').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return GlobalSpinner(context: context);
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                final snap = snapshot.data.docs[index].data();

                return GestureDetector(
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (details.primaryVelocity! < 0 && isLoggedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                            latitude: snap["startLatitude"],
                            longitude: snap["startLongitude"],
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }
                  },
                  child: SizedBox(
                    height: index == 0 ? size.height * 0.90 : size.height,
                    width: size.width,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                snap['tripUrl'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(
                                  0.8,
                                )
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                snap["tripTitle"].toString().toCapitalized(),
                                style:
                                    GoTheme.lightTextTheme.headline1?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Nyeri Kenya",
                                style:
                                    GoTheme.lightTextTheme.bodyText1?.copyWith(
                                  color: GoTheme.mainColor,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              Text(
                                snap['tripSummary'].toString().toCapitalized(),
                                style:
                                    GoTheme.lightTextTheme.bodyText1?.copyWith(
                                  color: Colors.white.withOpacity(
                                    0.7,
                                  ),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.045,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          32.0,
                                        ),
                                      ),
                                      minimumSize: const Size(
                                        100,
                                        40,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (isLoggedIn) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CommentsScreen(),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "View Comments",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: GoTheme.mainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          32.0,
                                        ),
                                      ),
                                      minimumSize: const Size(100, 40),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (isLoggedIn) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MapScreen(
                                                latitude: snap["startLatitude"],
                                                longitude:
                                                    snap["startLongitude"],
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        "View Map",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
