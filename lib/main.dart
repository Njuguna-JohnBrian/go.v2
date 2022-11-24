import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go/firebase_options.dart';
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
      home: WelcomeScreen(),
    );
  }
}
