import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go/globals/components/global_spinner.dart';
import 'package:go/theme/go_theme.dart';

class ProfileFollow extends StatefulWidget {
  const ProfileFollow({Key? key}) : super(key: key);

  @override
  State<ProfileFollow> createState() => _ProfileFollowState();
}

class _ProfileFollowState extends State<ProfileFollow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8),
              child: UserCard(
                username: snapshot.data.docs[index]['display_name'],
                actionText: "Follow",
                photoUrl: snapshot.data.docs[index]['photo_url'],
              ),
            ),
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
  const UserCard({
    Key? key,
    required this.photoUrl,
    required this.username,
    required this.actionText,
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
                onPressed: () {},
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
