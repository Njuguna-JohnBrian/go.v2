import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

import 'utils/strings.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          UsersStrings.title,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: GoTheme.mainColor,
            size: 35,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return buildUsersBody(context, size);
        },
      ),
    );
  }

  Widget buildUsersBody(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.all(
        8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: GoTheme.mainColor,
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                50,
              ),
              child: const Image(
                image: CachedNetworkImageProvider(
                  "https://tinyurl.com/kufs4ucf",
                ),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.05,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "John Brian",
                style: GoTheme.lightTextTheme.headline3,
                textAlign: TextAlign.center,
              ),
              buildFollowButton(
                context: context,
                actionText: "Follow",
                function: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildFollowButton({
    required BuildContext context,
    required String actionText,
    required Function() function,
    bool? isFollowers,
    bool? isFollowing,
    Color? backColor,
    Color? foreColor,
  }) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: backColor ?? Colors.grey.shade200,
        foregroundColor: foreColor ?? Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        minimumSize: const Size(
          100,
          35,
        ),
      ),
      child: Text(
        actionText,
      ),
    );
  }
}
