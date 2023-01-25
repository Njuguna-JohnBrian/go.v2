import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go/firebase_options.dart';
import 'package:go/screens/loading/loading_screen.dart';
import 'package:go/state/providers/auth/is_logged_in_provider.dart';
import 'package:go/state/providers/auth/isloading_provider.dart';

import 'package:go/theme/go_theme.dart';
import 'package:go/screens/screens_barrel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          ref.listen<bool>(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(
                context: context,
              );
            } else {
              LoadingScreen.instance().hide();
            }
          });
          final isLoggedIn = ref.watch(
            isLoggedInProvider,
          );

          if (isLoggedIn) {
            return const ConnectionScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
