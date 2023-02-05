import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go/theme/go_theme.dart';

class FollowScreen extends StatefulWidget {
  final List<dynamic> following;
  final List<dynamic> followers;
  final int currentIndex;
  const FollowScreen({
    Key? key,
    required this.following,
    required this.followers,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  @override
  void initState() {
    // widget.following.map((e) => print(e)).toList();
    super.initState();
  }

  Future getData({required List<dynamic> data}) async {
    for (var id in data) {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .get();

      return userSnap.data();
    }

    // data.map(
    //   (id) async =>
    //       await FirebaseFirestore.instance.collection("users").doc(id).get(),
    // );

    // var userSnap = await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc("839SMKPfBuhqZuDDaJI4ZTt7Vij1")
    //     .get();
    //
    // print(userSnap.data()!);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.following);
    final List<Tab> profileTabs = <Tab>[
      const Tab(
        child: Text("0 following"),
      ),
      const Tab(
        child: Text("0 followers"),
      )
    ];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: size.height * 0.05,
            color: GoTheme.mainColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "John Brian",
          style: GoTheme.lightTextTheme.headline6?.copyWith(
            color: GoTheme.mainColor,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: widget.currentIndex,
        animationDuration: const Duration(
          microseconds: 500,
        ),
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: GoTheme.mainLigtColor,
              labelColor: GoTheme.mainColor,
              labelStyle: GoTheme.lightTextTheme.headline6,
              indicatorColor: GoTheme.mainLigtColor,
              tabs: profileTabs,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                      itemCount: widget.following.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: widget.following.map((e) {
                                return Container(
                                  color: Colors.red,
                                  height: 10,
                                  width: 10,
                                );
                              }).toList()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Row(
//                               children: [
//                                 Container(
//                                   height: size.height * 0.090,
//                                   width: size.width * 0.18,
//                                   padding: const EdgeInsets.all(1.5),
//                                   decoration: BoxDecoration(
//                                     color: GoTheme.mainColor,
//                                     borderRadius: BorderRadius.circular(50),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(50),
//                                     child: const Image(
//                                       image: NetworkImage(
//                                         "https://tinyurl.com/kufs4ucf",
//                                       ),
//                                       filterQuality: FilterQuality.medium,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: size.width * 0.04,),
//                                 Text(
//                                   "John Brian Ngugi",
//                                   style: GoTheme.lightTextTheme.headline3,
//                                 ),
//                                 SizedBox(width: size.width * 0.04,),
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.grey.shade200,
//                                     foregroundColor: Colors.black,
//                                     minimumSize: const Size(
//                                       100,
//                                       35,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                         5,
//                                       ),
//                                     ),
//                                   ),
//                                   onPressed: () {},
//                                   child: const Text(
//                                     "Following",
//                                   ),
//                                 ),
//                               ],
//                              )


// Expanded(
//               child: TabBarView(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(15),
//                     child: ListView.builder(
//                       itemCount: widget.following.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(
//                             bottom: 10.0,
//                           ),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: widget.following.map((e) {
//                                 return Container(
//                                   color: Colors.red,
//                                   height: 10,
//                                   width: 10,
//                                 );
//                               }).toList()),
//                         );
//                       },
//                     ),
//                   ),
//                   Container(
//                     color: Colors.grey,
//                   ),
//                 ],
//               ),
//             ),