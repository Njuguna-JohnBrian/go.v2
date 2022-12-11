import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/globals/components/global_spinner.dart';
import 'package:go/theme/go_theme.dart';

import '../../../backend/backend_firestore.dart';

class ProfileFollow extends StatefulWidget {
  const ProfileFollow({Key? key}) : super(key: key);

  @override
  State<ProfileFollow> createState() => _ProfileFollowState();
}

class _ProfileFollowState extends State<ProfileFollow> {
  bool isLoading = false;
  var userData = {};
  bool isFollowing = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      userData = userSnap.data()!;
      isFollowing = userSnap.data()!["followers"].contains(
            FirebaseAuth.instance.currentUser!.uid,
          );
      // following = userData['following'].length;
      // followers = userData['followers'].length;
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? GlobalSpinner(context: context)
        : Scaffold(
            appBar: AppBar(
              title: const Text("Discover gO users"),
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.chevron_left,
                  color: GoTheme.mainColor,
                  size: 40,
                ),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where(
                    'uid',
                    isNotEqualTo: FirebaseAuth.instance.currentUser?.uid,
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return GlobalSpinner(context: context);
                }
                return GridView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: isFollowing
                          ? UserCard(
                              username: snapshot.data.docs[index]
                                  ['display_name'],
                              actionText: "Unfollow",
                              photoUrl: snapshot.data.docs[index]['photo_url'],
                              function: () async {
                                await FirestoreMethods().followUnfollowUser(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  snapshot.data.docs[index]['uid'],
                                );
                              },
                            )
                          : UserCard(
                              username: snapshot.data.docs[index]
                                  ['display_name'],
                              actionText: "Follow",
                              photoUrl: snapshot.data.docs[index]['photo_url'],
                              function: () async {
                                await FirestoreMethods().followUnfollowUser(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  snapshot.data.docs[index]['uid'],
                                );
                              },
                            ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                );
              },
            ),
          );
  }
}

class UserCard extends StatelessWidget {
  final String photoUrl;
  final String username;
  final String actionText;
  final Function() function;
  const UserCard({
    Key? key,
    required this.photoUrl,
    required this.username,
    required this.actionText,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        // color: Colors.redAccent,
        border: Border.all(
          color: Colors.black.withOpacity(
            0.25,
          ),
        ),
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 70,
            width: 70,
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              color: GoTheme.mainColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image(
                image: NetworkImage(photoUrl),
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
                username,
                style: GoTheme.lightTextTheme.headline3,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: function,
                style: ElevatedButton.styleFrom(
                  backgroundColor: GoTheme.mainColor,
                  minimumSize: const Size(140, 35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                child: Text(actionText),
              )
            ],
          )
        ],
      ),
    );
  }
}
