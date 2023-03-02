import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeStateNotifier extends StateNotifier<ThemeMode> {
  ThemeStateNotifier() : super(ThemeMode.system);

  Future<void> loadThemeFromPreference() async {
    final prefs = await SharedPreferences.getInstance();

    final isDarkMode = prefs.getBool('isDarkMode') ?? false;

    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    await prefs.setBool(
      "isDarkMode",
      state == ThemeMode.dark,
    );
  }
}
