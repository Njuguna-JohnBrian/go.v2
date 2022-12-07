import 'package:flutter/material.dart';

class SettingsTiles extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? action;
  const SettingsTiles({
    Key? key,
    required this.title,
    required this.icon,
    this.action,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: action,
    );
  }
}
