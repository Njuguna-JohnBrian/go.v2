import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.chevron_left,
            size: size.height * 0.05,
            color: GoTheme.mainColor,
          ),
        ),
        title: Text(
          "Settings",
          style: GoTheme.lightTextTheme.headline6?.copyWith(
            color: GoTheme.mainColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: ListView(
            children: [
              buildSettingsSection(
                context: context,
                size: size,
                title: "General",
                children: [
                  buildSettingsTile(
                    title: 'Dark Mode',
                    iconData: Icons.dark_mode_outlined,
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingsSection({
    required BuildContext context,
    required Size size,
    final String? title,
    required List<Widget> children,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: GoTheme.lightTextTheme.headline3,
            ),
          ),
        Column(
          children: children,
        )
      ],
    );
  }

  Widget buildSettingsTile({
    required String title,
    required IconData iconData,
    final Widget? trailing,
    final VoidCallback? action,
  }) {
    return ListTile(
      title: Text(title),
      leading: Icon(iconData),
      trailing: trailing,
      onTap: action,
    );
  }
}
