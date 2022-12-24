import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go/globals/components/global_spinner.dart';
import 'package:go/theme/go_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../state/providers/location/location_state_provider.dart';
import 'package:go/globals/string_extension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ViewScreen extends ConsumerStatefulWidget {
  const ViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ViewScreenState();
}

class _ViewScreenState extends ConsumerState<ViewScreen> {
  @override
  void initState() {
    ref.read(locationStateProvider.notifier).getLocation();
    super.initState();
  }

  getLocation({required double latitude, required double longitude}) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];

    return "${place.locality}, ${place.country}";
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
        builder: (context, AsyncSnapshot snapshot) => snapshot.data == null
            ? GlobalSpinner(context: context)
            : ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final snap = snapshot.data.docs[index].data();

                  return SizedBox(
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
                                    child: const Text(
                                      "View Comments",
                                      style: TextStyle(
                                        color: Colors.white,
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
                                    child: const Text(
                                      "View Map",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
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
                  );
                },
              ),
      ),
    );
  }
}
