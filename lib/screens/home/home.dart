import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/providers/providers_barrel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(child: Consumer(
        builder: (_, ref, child) {
          return TextButton(
            onPressed: ref.read(authStateProvider.notifier).logOut,
            child: const Text('LOGOUT'),
          );
        },
      )),
    );
  }
}
