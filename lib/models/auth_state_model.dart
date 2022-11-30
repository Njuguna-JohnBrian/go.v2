import 'package:flutter/foundation.dart' show immutable;


import 'package:go/typedefs/typedefs_barrel.dart';

@immutable
class AuthState {
  final String? response;
  final bool isLoading;
  final UserId? userId;

  const AuthState({
    required this.response,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : response = null,
        isLoading = false,
        userId = null;

  AuthState copiedWithIsLoading(bool isLoading) => AuthState(
        response: null,
        isLoading: isLoading,
        userId: userId,
      );

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (response == other.response &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        response,
        isLoading,
        userId,
      );
}
