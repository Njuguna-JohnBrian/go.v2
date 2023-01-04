import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go/firebase_options.dart';
import 'package:go/globals/components/global_snackbar.dart';
import 'package:go/globals/components/global_spinner.dart';
import 'package:go/screens/loading/loading_screen.dart';

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
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: ((context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.active) {
      //       if (snapshot.hasData) {
      //         return const HomeScreen();
      //       } else if (snapshot.hasError) {
      //         return Center(
      //           child: showSnackBar(
      //             context,
      //             "Error",
      //             "Internal Server Error",
      //             GoTheme.mainLightError,
      //             GoTheme.mainLightError,
      //             GoTheme.mainLightError,
      //           ),
      //         );
      //       }
      //     } else if (snapshot.connectionState == ConnectionState.waiting) {
      //       return GlobalSpinner(
      //         context: context,
      //       );
      //     }
      //     return const ViewScreen();
      //   }),
      // ),

      home: MainView()
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loading screen"),
      ),
      body: Center(
        child: Consumer(
          builder: (_, ref, child) {
            return TextButton(
              onPressed: () async {
                LoadingScreen.instance().show(
                  context: context,
                );
              },
              child: const Text(
                "Loading Screen",
              ),
            );
          },
        ),
      ),
    );
  }
}

