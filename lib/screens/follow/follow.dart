import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go/globals/globals_barrel.dart' show GlobalSpinner;
import 'package:go/theme/go_theme.dart';

class FollowScreen extends StatefulWidget {
  final List following;
  final List followers;
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
  var userData = [];
  late Future getFollowers;

  @override
  void initState() {
    getFollowers = getData();
    super.initState();
  }

  Future getData() async {
    final data = [
      "839SMKPfBuhqZuDDaJI4ZTt7Vij1",
      "er24ji8rbSeyn6H9swKVE4Er4Qt1",
      "w8yDHnBH4LTZjVjvNQeHsCHPZPT2"
    ];
    for (var id in data) {
      var userSnap =
          await FirebaseFirestore.instance.collection("users").doc(id).get();

      userData.add(userSnap.data());
    }
    return userData;
  }

  @override
  Widget build(BuildContext context) {
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
                    child: FutureBuilder(
                      future: getFollowers,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: userData.length,
                            itemExtent: 80,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    padding: const EdgeInsets.all(1.5),
                                    decoration: BoxDecoration(
                                      color: GoTheme.mainColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image(
                                        image: NetworkImage(
                                          "${snapshot.data[index]["photo_url"]}",
                                        ),
                                        filterQuality: FilterQuality.medium,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                      "${snapshot.data[index]["display_name"]}",
                                      style: GoTheme.lightTextTheme.headline3
                                          ?.copyWith(
                                              overflow: TextOverflow.fade)),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade200,
                                      foregroundColor: Colors.black,
                                      minimumSize: const Size(
                                        100,
                                        35,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Following",
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          return GlobalSpinner(context: context);
                        }
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
