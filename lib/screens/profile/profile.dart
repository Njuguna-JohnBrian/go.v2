import 'package:flutter/material.dart';
import 'package:go/animations/anims/empty_content_animation_view.dart';
import 'package:go/animations/anims/error_animation_view.dart';
import 'package:go/animations/anims/loading_animation_view.dart';
import 'package:go/screens/profile/components/profile_builder.dart';
import 'package:go/state/providers/userdata/userdata_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    return RefreshIndicator(
      child: userData.when(
        data: (userData) {
          if (userData.isEmpty) {
            return const EmptyContentAnimationView();
          } else {
            return ProfileBuilder(
              userData: userData,
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
      onRefresh: () {
        ref.refresh(userDataProvider);
        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
    );
  }
}
