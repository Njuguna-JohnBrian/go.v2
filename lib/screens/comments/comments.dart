import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class CommentsScreen extends StatelessWidget {
  final Size size;
  const CommentsScreen({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight:size.height * 0.15,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 35,
                color: GoTheme.mainColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Comments",
              style: GoTheme.lightTextTheme.headline6?.copyWith(
                color: GoTheme.mainColor,
              ),
            ),
          ),
          body: Container(),
          bottomNavigationBar: SafeArea(
            child: Container(
              height: kToolbarHeight,
              padding: const EdgeInsets.only(
                left: 16,
                right: 18,
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      "https://tinyurl.com/2p99uwwf",
                    ),
                    radius: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 18,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:
                              "Comment as ${FirebaseAuth.instance.currentUser?.displayName}",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: const Text(
                        "Post",
                        style: TextStyle(
                          color: GoTheme.mainColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
