import 'package:flutter/material.dart';
import 'package:go/screens/screens_barrel.dart';
import 'package:go/state/providers/auth/auth_state_provider.dart';
import 'package:go/state/providers/theme/theme.provider.dart';
import 'package:go/theme/go_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  final List following;
  final List followers;
  const SettingsScreen({
    Key? key,
    required this.following,
    required this.followers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final theme = ref.watch(themeStateProvider);
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
                    title: theme == ThemeMode.dark ? 'Dark Mode' : "Light Mode",
                    iconData: Icons.dark_mode_outlined,
                    trailing: Switch(
                      value: theme == ThemeMode.dark ? false : true,
                      onChanged: (value) =>
                          ref.read(themeStateProvider.notifier).toggleTheme(),
                    ),
                  ),
                  buildSettingsTile(
                    title: "Notifications",
                    iconData: Icons.notifications_none_outlined,
                  ),
                  buildSettingsTile(
                    title: "Enable Location",
                    iconData: Icons.share_location,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  buildSettingsSection(
                    context: context,
                    size: size,
                    title: "Organization",
                    children: [
                      buildSettingsTile(
                          title: "Profile",
                          iconData: Icons.person_outline_rounded,
                          action: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                          }),
                      buildSettingsTile(
                        title: "Messaging",
                        iconData: Icons.message_outlined,
                      ),
                      buildSettingsTile(
                          title: "Followers",
                          iconData: Icons.person_add_alt_1_outlined,
                          action: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FollowScreen(
                                  following: following,
                                  followers: followers,
                                  currentIndex: 1,
                                ),
                              ),
                            );
                          }),
                      buildSettingsTile(
                        title: "Following",
                        iconData: Icons.person_add_outlined,
                        action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FollowScreen(
                                following: following,
                                followers: followers,
                                currentIndex: 0,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  buildSettingsSection(
                    context: context,
                    size: size,
                    title: "More",
                    children: [
                      buildSettingsTile(
                        title: "Help & Feedback",
                        iconData: Icons.help_outline_outlined,
                      ),
                      buildSettingsTile(
                        title: "About",
                        iconData: Icons.info_outline_rounded,
                      ),
                      buildSettingsTile(
                        title: "Privacy Policy",
                        iconData: Icons.privacy_tip_outlined,
                      ),
                      Consumer(
                        builder: (
                          _,
                          ref,
                          child,
                        ) {
                          return buildSettingsTile(
                            title: "Log Out",
                            iconData: Icons.exit_to_app_rounded,
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
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline3,
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
