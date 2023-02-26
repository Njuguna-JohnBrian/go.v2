import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

import 'utils/strings.dart';

class CommentsScreen extends StatelessWidget {
  final Size size;
  final String tripId;
  const CommentsScreen({
    Key? key,
    required this.size,
    required this.tripId,
  }) : super(key: key);

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
            toolbarHeight: size.height * 0.15,
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
              CommentsStrings.screenTitle,
              style: GoTheme.lightTextTheme.headline6?.copyWith(
                color: GoTheme.mainColor,
              ),
            ),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("trips")
                .doc(tripId)
                .collection("comments")
                .orderBy(
                  "datePublished",
                  descending: true,
                )
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LinearProgressIndicator();
              }

              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => Text(""),
                separatorBuilder: (
                  BuildContext context,
                  int index,
                ) =>
                    SizedBox(
                  height: size.height * 0.015,
                ),
              );
            },
          ),
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
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      "${FirebaseAuth.instance.currentUser!.photoURL}",
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
                              "${CommentsStrings.commentAs} ${FirebaseAuth.instance.currentUser?.displayName}",
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

  Widget buildComment({
    required BuildContext context,
    required Size size,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        children: [],
      ),
    );
  }
}
