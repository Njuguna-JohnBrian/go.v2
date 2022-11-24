import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:go/models/models_barrel.dart';
import 'package:go/typedefs/typedefs_barrel.dart';

import 'constants/backend_constants_barrel.dart';

class Authenticator {
  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;

  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  //Logout of all auth providers
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  //Google Login
  Future<AuthResult> logInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [ConstantsScopes.emailScope],
    );

    final signInAccount = await googleSignIn.signIn();

    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;

    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );

      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  //Facebook Login
  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();

    final token = loginResult.accessToken?.token;
    if (token == null) {
      //user has aborted login process
      return AuthResult.aborted;
    }

    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );

      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;

      if (e.code == ConstantsScopes.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(
          email,
        );
        if (providers.contains(
          ConstantsScopes.googleCom,
        )) {
          await logInWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(
            credential,
          );
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }
}
