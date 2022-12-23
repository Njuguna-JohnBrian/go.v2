import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class ViewScreenBody extends StatefulWidget {
  const ViewScreenBody({Key? key}) : super(key: key);

  @override
  State<ViewScreenBody> createState() => _ViewScreenBodyState();
}

class _ViewScreenBodyState extends State<ViewScreenBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
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
    );
  }
}
