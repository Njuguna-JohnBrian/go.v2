import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go/state/notifiers/notifiers_barrel.dart'
    show ThemeStateNotifier;

final themeStateProvider = StateNotifierProvider<ThemeStateNotifier, ThemeMode>(
  (ref) {
    return ThemeStateNotifier();
  },
);
