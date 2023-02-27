import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/backend/backend_barrel.dart';
import 'package:go/theme/go_theme.dart';
import 'package:intl/intl.dart';

import 'utils/strings.dart';

class CommentsScreen extends StatefulWidget {
  final Size size;
  final String tripId;
  const CommentsScreen({
    Key? key,
    required this.size,
    required this.tripId,
  }) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final GlobalKey<FormState> _commentFormKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: widget.size.height * 0.15,
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
                .doc(widget.tripId)
                .collection("comments")
                .orderBy(
                  "datePublished",
                  descending: true,
                )
                .snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LinearProgressIndicator();
              }

              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => buildComment(
                  context: context,
                  size: widget.size,
                  snap: snapshot.data!.docs[index].data(),
                ),
                separatorBuilder: (
                  BuildContext context,
                  int index,
                ) =>
                    SizedBox(
                  height: widget.size.height * 0.015,
                ),
              );
            },
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: kToolbarHeight,
              padding: const EdgeInsets.only(
                left: 16,
                right: 18,
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _commentFormKey,
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
                        child: TextFormField(
                          controller: _commentController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return "Comment cannot be empty";
                            }
                            return null;
                          }),
                          decoration: InputDecoration(

                            hintText:
                                "${CommentsStrings.commentAs} ${FirebaseAuth.instance.currentUser?.displayName}",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (_commentFormKey.currentState!.validate()) {
                          await TripFirebaseMethods().addComment(
                            widget.tripId,
                            _commentController.text,
                            FirebaseAuth.instance.currentUser!.uid,
                            "${FirebaseAuth.instance.currentUser!.displayName}",
                            "${FirebaseAuth.instance.currentUser!.photoURL}",
                          );
                          _commentController.clear();
                        }
                      },
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
      ),
    );
  }

  Widget buildComment({
    required BuildContext context,
    required Size size,
    required dynamic snap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              snap["userAvatar"],
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        snap["userName"],
                      ),
                      Text(snap["comment"])
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      DateFormat.yMMMd().format(
                        snap["datePublished"].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
