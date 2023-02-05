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
      ),
    );
  }
}
