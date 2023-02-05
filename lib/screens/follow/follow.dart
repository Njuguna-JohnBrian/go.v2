import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class FollowScreen extends StatefulWidget {
  const FollowScreen({Key? key}) : super(key: key);

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
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
        initialIndex: 0,
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

          ],
        ),
      ),
    );
  }
}
