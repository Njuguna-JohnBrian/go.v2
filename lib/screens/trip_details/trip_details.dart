import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/screens/trip_details/trip_details_drawer.dart';

import 'package:go/theme/go_theme.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: GoTheme.mainColor,
        ),
        title: Center(
          child: SvgPicture.asset(
            'assets/svgs/logo.svg',
            height: 50,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: GoTheme.mainColor,
          ),
        ),
      ),
      endDrawer: TripDetailsDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  "https://images.pexels.com/photos/5241381/pexels-photo-5241381.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260",
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
          // Container(
          //   height: 100,
          //   width: double.infinity,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Text(
          //         "John Brian",
          //         style: const TextStyle(
          //           color: Colors.white,
          //           fontSize: 30,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       Text(
          //         "Nyeri, Kenya",
          //         style: const TextStyle(
          //           color: Colors.white,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 20,
          //       ),
          //       Text(
          //         "Kenya is lit",
          //         style: TextStyle(
          //           color: Colors.white.withOpacity(
          //             0.7,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 40,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           TextButton(
          //             child: const Text(
          //               'View Comments',
          //               style: TextStyle(
          //                 color: Colors.white,
          //               ),
          //             ),
          //             onPressed: () {},
          //           ),
          //           ClipRRect(
          //             borderRadius: BorderRadius.circular(
          //               20,
          //             ),
          //             child: Material(
          //               color: GoTheme.mainColor,
          //               child: InkWell(
          //                 onTap: () {},
          //                 splashColor: Colors.black.withOpacity(
          //                   0.1,
          //                 ),
          //                 highlightColor: Colors.black.withOpacity(0.2),
          //                 child: Container(
          //                   padding: const EdgeInsets.only(
          //                     top: 10,
          //                     left: 20,
          //                     bottom: 10,
          //                     right: 20,
          //                   ),
          //                   child: const Text(
          //                     'View Trip',
          //                     style: TextStyle(
          //                       color: Colors.white,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
