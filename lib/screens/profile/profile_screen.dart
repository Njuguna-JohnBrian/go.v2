import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:go/animations/animations_barrel.dart'
    show EmptyContentAnimationView, LoadingAnimationView, ErrorAnimationView;

import 'package:go/state/state_barrel.dart' show userDataProvider;

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    return RefreshIndicator(
      backgroundColor: GoTheme.mainColor,
      color: Colors.white,
      onRefresh: () {
        return Future.delayed(
          const Duration(
            seconds: 3,
          ),
        );
      },
      child: userData.when(
        data: (userData) {
          if (userData.isEmpty) {
            return const EmptyContentAnimationView();
          } else {
            return const Center(
              child: LoadingAnimationView(),
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
