import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final auth = FirebaseAuth.instance;
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      final cred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something Went Wrong");
    }
    return null;
  }
}
