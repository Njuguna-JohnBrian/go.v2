import 'package:flutter/material.dart';
import 'package:go/globals/components/global_snackbar.dart';
import 'package:go/theme/go_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quickalert/quickalert.dart';

import 'package:go/models/models_barrel.dart';
import '../../../backend/backend_barrel.dart';
import '../../../screens/screens_barrel.dart';
import '../../../typedefs/typedefs_barrel.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier()
      : super(
          const AuthState.unknown(),
        ) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut({required BuildContext context}) async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle({required BuildContext context}) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.logInWithGoogle();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithFacebook({required BuildContext context}) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> createAccount({
    required String email,
    required String password,
    required String displayName,
    required BuildContext context,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.createAccount(
      email: email,
      password: password,
    );
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveNewUserInfo(
        userId: userId,
        displayName: displayName,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }

    if (result == AuthResult.failure) {
      showSnackBar(
        context,
        "Wrong credentials",
        "Please check your email and retry",
        GoTheme.mainError,
        GoTheme.mainLightError,
        GoTheme.mainLightError,
      );
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginUser(
      email: email,
      password: password,
    );
    final userId = _authenticator.userId;

    if (result == AuthResult.success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }

    if (result == AuthResult.failure) {
      showSnackBar(
        context,
        "Wrong credentials",
        "Please check your details and retry",
        GoTheme.mainError,
        GoTheme.mainLightError,
        GoTheme.mainLightError,
      );
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> sendResetLink({
    required String email,
    required BuildContext context,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.sendResetLink(
      email: email,
    );
    final userId = _authenticator.userId;

    if (result == AuthResult.success) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: "Success",
        text: "Reset link sent successfully",
        barrierDismissible: false,
        confirmBtnColor: GoTheme.mainColor,
      );
    }

    if (result == AuthResult.failure) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Failed to send",
        text: "Please check your email and retry",
        barrierDismissible: false,
        confirmBtnColor: GoTheme.mainColor,
      );
    }

    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );

  Future<void> saveNewUserInfo({
    required UserId userId,
    required String displayName,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: displayName,
        email: _authenticator.email,
      );
}
