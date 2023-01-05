import 'package:flutter/material.dart';
import 'package:go/state/state_barrel.dart';
import 'package:go/theme/go_theme.dart';

import 'package:go/screens/settings/settings_barrel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: isDark ? GoTheme.dark() : GoTheme.light(),
      child: Scaffold(
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
            'Settings',
            style: GoTheme.lightTextTheme.headline6
                ?.copyWith(color: GoTheme.mainColor),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                SettingsSections(
                  title: "General",
                  children: [
                    SettingsTiles(
                      title: "Dark Mode",
                      icon: Icons.dark_mode_outlined,
                      trailing: Switch(
                        value: isDark,
                        onChanged: (value) {
                          setState(() {
                            isDark = value;
                          });
                        },
                      ),
                    ),
                    const SettingsTiles(
                      title: "Notifications",
                      icon: Icons.notifications_none_outlined,
                    ),
                    const SettingsTiles(
                      title: "Enable Location",
                      icon: Icons.share_location,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                  ],
                ),
                 SettingsSections(
                  title: "Organization",
                  children: [
                    const SettingsTiles(
                      title: "Profile",
                      icon: Icons.person_outline_rounded,
                    ),
                    const SettingsTiles(
                      title: "Messaging",
                      icon: Icons.message_outlined,
                    ),
                    SettingsTiles(
                      title: "Followers",
                      icon: Icons.person_add_alt_1_outlined,
                      action: (){},
                    ),
                    SettingsTiles(
                      title: "Following",
                      icon: Icons.person_add_outlined,
                      action: (){},
                    )
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                SettingsSections(
                  title: "More",
                  children: [
                    const SettingsTiles(
                      title: "Help & Feedback",
                      icon: Icons.help_outline_outlined,
                    ),
                    const SettingsTiles(
                      title: "About",
                      icon: Icons.info_outline_rounded,
                    ),
                    const SettingsTiles(
                      title: "Privacy Policy",
                      icon: Icons.privacy_tip_outlined,
                    ),
                    Consumer(
                      builder: (_, ref, child) {
                        return SettingsTiles(
                          title: "Log out",
                          icon: Icons.exit_to_app_rounded,
                          action: () => ref
                              .read(
                                authStateProvider.notifier,
                              )
                              .logOut(
                                context: context,
                              ),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
