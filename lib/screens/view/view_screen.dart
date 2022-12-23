import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/theme/go_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/providers/location/location_state_provider.dart';
import 'components/view_drawer.dart';
import 'components/view_screen_body.dart';

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
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return SizedBox(
              height: index == 0 ? size.height * 0.90 : size.height,
              width: size.width,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
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
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Harbour Bridge",
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
                          "A trip around Africa and it's environs",
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
                                    borderRadius: BorderRadius.circular(32.0)),
                                minimumSize: const Size(100, 40),
                              ),
                              child: const Text(
                                "View Comments",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: GoTheme.mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                minimumSize: const Size(100, 40),
                              ),
                              child: const Text(
                                "View Comments",
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
          }),
    );
  }
}
