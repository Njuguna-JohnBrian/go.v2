import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:go/state/providers/providers_barrel.dart'
    show authStateProvider;

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (_, ref, child) {
            return ElevatedButton(
              onPressed: () => ref.read(authStateProvider.notifier).logOut(
                    context: context,
                  ),
              child: const Text("Logout"),
            );
          },
        ),
      ),
    );
  }
}
