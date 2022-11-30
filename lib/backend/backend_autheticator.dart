import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


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
  Future<String> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();

      return "Goodbye 👋.\n We hope to see you soon";
    } catch (error) {
      return "Failed to logout.\n Please retry";
    }
  }

  //Google Login
  Future<String> logInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [ConstantsScopes.emailScope],
    );

    final signInAccount = await googleSignIn.signIn();

    if (signInAccount == null) {
      return "Aborted";
    }

    final googleAuth = await signInAccount.authentication;

    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    try {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );
      final response = userCredential.additionalUserInfo!.isNewUser
          ? "New account created successfully.Please remember to set your password"
          : "Welcome back to go!.We are glad to see you back.";

      return response;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'account-exists-with-different-credential') {
        return "Account exists with different credential";
      } else if (error.code == 'invalid-credential') {
        return "Invalid credentials";
      } else if (error.code == 'invalid-email') {
        return "The email address is badly formatted";
      } else {
        return "Some error occurred";
      }
    }
  }

  //Facebook Login
  Future<String> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();

    final token = loginResult.accessToken?.token;
    if (token == null) {
      //user has aborted login process
      return "Aborted";
    }

    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );
      final response = userCredential.additionalUserInfo!.isNewUser
          ? "New account created successfully.Please remember to set your password"
          : "Welcome back to go!.We are glad to see you back.";

      return response;
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
        return "Account details updated";
      }
      return "Failed to login with Facebook";
    }
  }

  //Create account with Email and password
  Future<String> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "Account Created Successfully\nWelcome to gO!";
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        return 'Password should be at-least 8 characters';
      } else if (error.code == 'invalid-email') {
        return 'The email address is badly formatted.';
      } else if (error.code == 'email-already-in-use') {
        return 'The email address is already in use by another account.';
      } else if (error.code == 'network-request-failed') {
        return "Network Error";
      } else {
        return "Some error occurred";
      }
    }
  }

  //Login with Email and password
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Welcome back to go!.We are glad to see you back.";
    } on FirebaseAuthException catch (error) {
      if (error.code == 'network-request-failed') {
        return "Network Error.Please turn on your network connection";
      } else if (error.code == 'user-not-found') {
        return 'User not found.Please use correct credentials';
      } else if (error.code == 'wrong-password') {
        return 'The password is invalid';
      } else if (error.code == 'invalid-email') {
        return "The email address is badly formatted";
      } else {
        return "Some error occurred";
      }
    }
  }

  //Send reset link
  Future<String> sendResetLink({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return "Please check your email for a reset link we just sent you.";
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        return "User not found.Please use correct email";
      } else if (error.code == 'network-request-failed') {
        return "Network Error.Please turn on your network connection";
      } else if (error.code == 'invalid-email') {
        return "The email address is badly formatted";
      } else {
        return "Some error occurred";
      }
    }
  }
}
