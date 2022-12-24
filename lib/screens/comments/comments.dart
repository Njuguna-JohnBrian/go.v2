import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: GoTheme.mainColor,
        title: const Text(
          'Comments',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(
            left: 16,
            right: 8,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  FirebaseAuth.instance.currentUser?.photoURL ??
                      'https://tinyurl.com/2p99uwwf',
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 8,
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText:
                            'Comment as ${FirebaseAuth.instance.currentUser?.displayName}',
                        border: InputBorder.none),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    _controller.text = "";
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: const Text(
                    'Post',
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
    );
  }
}
