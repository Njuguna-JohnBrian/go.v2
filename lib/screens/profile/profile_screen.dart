import 'package:flutter/material.dart';
import 'package:go/animations/anims/empty_content_animation_view.dart';
import 'package:go/animations/anims/error_animation_view.dart';
import 'package:go/animations/anims/loading_animation_view.dart';
import 'package:go/state/state_barrel.dart' show userDataProvider;
import 'package:go/theme/go_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
