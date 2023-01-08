import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go/backend/trips/trips_model.dart';
import 'package:go/globals/string_extension.dart';
import 'package:go/screens/comments/comments.dart';
import 'package:go/screens/login/login_barrel.dart';
import 'package:go/screens/maps/maps.dart';
import 'package:go/theme/go_theme.dart';

class ViewBody extends StatelessWidget {
  final TripsModel trips;
  final bool isLoggedIn;
  const ViewBody({
    Key? key,
    required this.trips,
    required this.isLoggedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! < 0 && isLoggedIn) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapScreen(
                latitude: trips.startLatitude,
                longitude: trips.startLongitude,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      },
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    trips.tripUrl,
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
                    trips.tripTitle.toString().toCapitalized(),
                    style: GoTheme.lightTextTheme.headline1?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Nyeri Kenya",
                    style: GoTheme.lightTextTheme.bodyText1?.copyWith(
                      color: GoTheme.mainColor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Text(
                    trips.tripSummary.toString().toCapitalized(),
                    style: GoTheme.lightTextTheme.bodyText1?.copyWith(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  builder: (context) => const CommentsScreen(),
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
                                    latitude: trips.startLatitude,
                                    longitude: trips.startLongitude,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
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
  }
}
