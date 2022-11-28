import 'package:flutter/material.dart';
import 'package:go/state/providers/auth/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (_, ref, _child) {
            return ElevatedButton(
              onPressed: () => ref.read(authStateProvider.notifier).logOut(
                    context: context,
                  ),
              child: Text("Logout"),
            );
          },
        ),
      ),
    );
  }
}
