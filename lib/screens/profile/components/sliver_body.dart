import 'package:flutter/material.dart';

class ProfileSliverBody extends StatefulWidget {
  const ProfileSliverBody({Key? key}) : super(key: key);

  @override
  State<ProfileSliverBody> createState() => _ProfileSliverBodyState();
}

class _ProfileSliverBodyState extends State<ProfileSliverBody> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.red
          ),
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(
                    child: Text("Trips"),
                  ),
                  Tab(
                    child: Text("Trips"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
