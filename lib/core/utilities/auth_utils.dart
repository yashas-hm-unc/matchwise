import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchwise/core/models/api_response.dart';
import 'package:matchwise/core/models/matchwise_user.dart';

Future<ApiResponse> googleSignIn() async {
  try {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({
      'login_hint': 'onyen@cs.unc.edu',
      'hd': 'cs.unc.edu',
    });

    await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  } on FirebaseAuthException catch (e, s) {
    if (e.code == 'email-already-in-use') {
      log('Error @ Google Login: $e', error: e, stackTrace: s);
      return const ApiResponse(
        message:
            'The email address is already used with another service, so please select the one you signed up for.',
      );
    }
  } catch (e, s) {
    log(
      'Error @ Google Login: $e',
      error: e,
      stackTrace: s,
    );
  }

  return const ApiResponse(
    message: 'Some unexpected error occurred',
  );
}

Future<ApiResponse> debugSignin({
  UserType type = UserType.admin,
}) async {
  try {
    switch (type) {
      case UserType.admin:
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'yashashm@cs.unc.edu',
          password: '123456',
        );
        break;
      case UserType.student:
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'agreen@cs.unc.edu',
          password: '123456',
        );
        break;
      case UserType.faculty:
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'asmith@cs.unc.edu',
          password: '123456',
        );
        break;
    }
    return const ApiResponse(success: true);
  } catch (e, s) {
    log(
      'Error @ Google Login: $e',
      error: e,
      stackTrace: s,
    );
  }

  return const ApiResponse();
}
