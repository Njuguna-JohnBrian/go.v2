import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/theme/go_theme.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: SvgPicture.asset(
            'assets/svgs/logo.svg',
            height: 50,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
            color: GoTheme.mainColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              size: 35,
              color: GoTheme.mainColor,
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
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
            height: size.height,
            width: size.width,
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
          Container(
            height: size.height * 0.30,
            width: size.width,
            padding: const EdgeInsets.all(
              20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John Brian",
                  style: GoTheme.darkTextTheme.headline1,
                ),
                Text(
                  "Nyeri Kenya",
                  style: GoTheme.darkTextTheme.bodyText1,
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Text(
                  "A trip along the Himalaya mountains across the Indies",
                  style: GoTheme.darkTextTheme.bodyText2?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildButton(
                      context: context,
                      size: size,
                      color: Colors.black.withOpacity(
                        0.8,
                      ),
                      actionText: "View Comments",
                    ),
                    buildButton(
                      context: context,
                      size: size,
                      color: GoTheme.mainColor,
                      actionText: "Track Trip",
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildButton({
    required BuildContext context,
    required Size size,
    required Color color,
    required String actionText,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        20,
      ),
      child: Material(
        color: color,
        child: InkWell(
          onTap: () {},
          splashColor: Colors.black.withOpacity(
            0.1,
          ),
          highlightColor: Colors.black.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              bottom: 10,
              right: 20,
            ),
            child: Text(
              actionText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
