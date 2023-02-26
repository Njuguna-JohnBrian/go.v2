import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/backend/backend_barrel.dart';
import 'package:go/screens/screens_barrel.dart';
import 'package:go/screens/tripDetails/utils/like_animation.dart';
import 'package:go/theme/go_theme.dart';

import 'utils/strings.dart';

class TripDetailsScreen extends StatefulWidget {
  final String tripTitle;
  final String tripSummary;
  final String startLocation;
  final String tripCover;
  final List likes;
  final String userId;
  final String tripId;
  const TripDetailsScreen({
    Key? key,
    required this.tripTitle,
    required this.tripSummary,
    required this.startLocation,
    required this.tripCover,
    required this.likes,
    required this.userId,
    required this.tripId,
  }) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onDoubleTap: () async {
        await TripFirebaseMethods().likeTrip(
          widget.tripId,
          widget.userId,
          widget.likes,
        );
        setState(() {
          isLikeAnimating = true;
        });
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Center(
            child: SvgPicture.asset(
              TripDetailsStrings.svgLogo,
              height: 50,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 35,
              color: GoTheme.mainColor,
            ),
          ),
          actions: [
            LikeAnimation(
              isAnimating: widget.likes.contains(widget.userId),
              smallLike: true,
              child: IconButton(
                onPressed: () async {
                  await TripFirebaseMethods().likeTrip(
                    widget.tripId,
                    widget.userId,
                    widget.likes,
                  );
                  setState(() {
                    isLikeAnimating = true;
                  });
                },
                icon: widget.likes.contains(
                  widget.userId,
                )
                    ? const Icon(
                        Icons.favorite,
                        size: 35,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        size: 35,
                      ),
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    widget.tripCover,
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
            Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 120,
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
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
                    widget.tripTitle,
                    style: GoTheme.darkTextTheme.headline1,
                  ),
                  Text(
                    widget.startLocation,
                    style: GoTheme.darkTextTheme.bodyText1,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Text(
                    widget.tripSummary,
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
                        actionText: TripDetailsStrings.viewComments,
                        tripId: widget.tripId,
                      ),
                      buildButton(
                        context: context,
                        size: size,
                        color: GoTheme.mainColor,
                        actionText: TripDetailsStrings.trackTrip,
                        tripId: widget.tripId,
                      ),
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

  Widget buildButton({
    required BuildContext context,
    required Size size,
    required Color color,
    required String actionText,
    required String tripId,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        20,
      ),
      child: Material(
        color: color,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    30,
                  ),
                  topRight: Radius.circular(
                    30,
                  ),
                ),
              ),
              context: context,
              builder: (BuildContext context) {
                return CommentsScreen(
                  size: size,
                  tripId: tripId,
                );
              },
            );
          },
          splashColor: Colors.black.withOpacity(
            0.1,
          ),
          highlightColor: Colors.black.withOpacity(
            0.2,
          ),
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
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
