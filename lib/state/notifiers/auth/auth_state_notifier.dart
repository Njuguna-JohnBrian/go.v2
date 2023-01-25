import 'package:flutter/material.dart';
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
        response: AuthResult.success.toString(),
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut({required BuildContext context}) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.logOut();
    if (!result.contains("soon")) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Failed",
        text: result,
        barrierDismissible: false,
        confirmBtnColor: const Color(0xFFC4144D),
      );
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: "Success",
          text: result,
          barrierDismissible: false,
          confirmBtnColor: GoTheme.mainSuccess,
          onConfirmBtnTap: () {});
    }

    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle({required BuildContext context}) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.logInWithGoogle();
    final userId = _authenticator.userId;

    if (result.contains("successfully") ||
        result.contains('Welcome') && userId != null) {
      await saveUserInfo(
        userId: userId!,
      );
      state = state.copiedWithIsLoading(false);

      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: "Welcome",
          text: result,
          barrierDismissible: false,
          confirmBtnColor: GoTheme.mainSuccess,
          onConfirmBtnTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          });
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Failed",
        text: result,
        barrierDismissible: false,
        confirmBtnColor: const Color(0xFFC4144D),
      );
    }

    state = AuthState(
      response: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> loginWithFacebook({required BuildContext context}) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;

    if (result.contains('successfully') ||
        result.contains('Welcome') && userId != null) {
      await saveUserInfo(
        userId: userId!,
      );
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: "Welcome",
          text: result,
          barrierDismissible: false,
          confirmBtnColor: GoTheme.mainSuccess,
          onConfirmBtnTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          });
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Failed",
        text: result,
        barrierDismissible: false,
        confirmBtnColor: const Color(0xFFC4144D),
      );
    }

    state = AuthState(
      response: result,
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
    if (result.contains("Successfully") && userId != null) {
      await saveNewUserInfo(
        userId: userId,
        displayName: displayName,
      );
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: "Welcome",
          text: result,
          barrierDismissible: false,
          confirmBtnColor: GoTheme.mainSuccess,
          onConfirmBtnTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          });
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Failed",
        text: result,
        barrierDismissible: false,
        confirmBtnColor: const Color(0xFFC4144D),
      );
    }

    state = AuthState(
      response: result,
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

    if (result.contains('Welcome')) {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: "Welcome",
          text: result,
          barrierDismissible: false,
          confirmBtnColor: GoTheme.mainSuccess,
          onConfirmBtnTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          });
    }
    if (!result.contains("Welcome")) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Failed",
        text: result,
        barrierDismissible: false,
        confirmBtnColor: const Color(0xFFC4144D),
      );
    }

    state = AuthState(
      response: result,
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

    if (result.contains('sent')) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: "Success",
        text: "Reset link sent successfully",
        barrierDismissible: false,
        confirmBtnColor: GoTheme.mainColor,
      );
    }

    state = AuthState(
      response: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
          userId: userId,
          displayName: _authenticator.displayName,
          email: _authenticator.email,
          photoUrl: _authenticator.photoUrl);

  Future<void> saveNewUserInfo({
    required UserId userId,
    required String displayName,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: displayName,
        email: _authenticator.email,
        photoUrl: '',
      );
}
