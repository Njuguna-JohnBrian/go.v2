import 'package:flutter/material.dart';
import 'package:go/animations/anims/empty_contents_wih_text_animation_view.dart';
import 'package:go/animations/anims/error_animation_view.dart';
import 'package:go/animations/anims/loading_animation_view.dart';
import 'package:go/state/providers/auth/is_logged_in_provider.dart';
import 'package:go/state/providers/trips/trips_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/view_builder.dart';
import 'constants/constants.dart';

class ViewScreen extends ConsumerWidget {
  const ViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(userTripsProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    return RefreshIndicator(
      child: trips.when(
        data: (trips) {
          if (trips.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: ViewStrings.noPostsAvailable,
            );
          } else {
            return ViewBuilder(
              trips: trips,
              isLoggedIn: isLoggedIn,
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
        ref.refresh(userTripsProvider);
        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
    );
  }
}
