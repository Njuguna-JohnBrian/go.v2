import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final String actionText;
  final Function() function;
  final bool? isFollowing;
  final bool? isFollower;
  const FollowButton({
    Key? key,
    required this.actionText,
    required this.function,
    this.isFollowing,
    this.isFollower,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.black,
        minimumSize: const Size(100, 35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
      ),
      child: Text(actionText),
    );
  }
}