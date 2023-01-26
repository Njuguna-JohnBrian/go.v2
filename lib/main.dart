import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go/firebase_options.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:go/theme/go_theme.dart' show GoTheme;

import 'package:go/state/state_barrel.dart'
    show
        NetworkStatus,
        isLoadingProvider,
        isLoggedInProvider,
        networkAwareProvider;

import 'package:go/screens/screens_barrel.dart'
    show LoadingScreen, ConnectionScreen, HomeScreen, LoginScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: Go(),
    ),
  );
}

class Go extends StatelessWidget {
  const Go({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GoTheme.light(),
      title: 'gO',
      home: Consumer(
        builder: (context, ref, child) {
          final isLoggedIn = ref.watch(
            isLoggedInProvider,
          );

          final network = ref.watch(
            networkAwareProvider,
          );

          ref.listen<bool>(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(
                context: context,
              );
            } else {
              LoadingScreen.instance().hide();
            }
          });

          if (isLoggedIn && network == NetworkStatus.off ||
              isLoggedIn && network == NetworkStatus.notDetermined) {
            return const ConnectionScreen();
          }

          final network = ref.watch(networkAwareProvider);

          if (isLoggedIn) {
            if (network == NetworkStatus.off) {
              return const ConnectionScreen();
            } else {
              return const HomeScreen();
            }
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
