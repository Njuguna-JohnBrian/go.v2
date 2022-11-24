import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go/state/state_barrel.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: ref.read(authStateProvider.notifier).loginWithFacebook,
                child: Text('FACEBOOK'),
              ),
              GestureDetector(
                onTap: ref.read(authStateProvider.notifier).loginWithGoogle,
                child: Text('Google'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
