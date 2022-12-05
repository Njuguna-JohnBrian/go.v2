import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go/theme/go_theme.dart';

import 'package:go/globals/global_assets.dart';
import 'package:go/screens/profile/profile_barrel.dart';

class ProfileSliverAppBar extends StatelessWidget {
  const ProfileSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: size.height * 0.4,
      backgroundColor: Colors.transparent,
      leading: SvgPicture.asset(
        GlobalAssets.logoSvg,
        height: 100,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            color: GoTheme.mainColor,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
            color: GoTheme.mainColor,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ProfileAssets.worldMap),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: const Image(
                      image: NetworkImage("https://tinyurl.com/2p99uwwf"),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
                Text(
                  "John Brian Ngugi Njuguna",
                  style: GoTheme.darkTextTheme.bodyText1,
                ),
                Text(
                  "Nyeri, Kenya",
                  style: GoTheme.darkTextTheme.bodyText1?.copyWith(
                    color: Colors.grey[900],
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        width: 70,
                        height: 20,
                        child: Text(
                          "0 following",
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
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        width: 70,
                        height: 20,
                        child: Text(
                          "0 followers",
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
                            color: Colors.black.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: const Icon(
                          Icons.person_add_alt_outlined,
                          color: Colors.white,
                          size: 15,
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
    );
  }
}
