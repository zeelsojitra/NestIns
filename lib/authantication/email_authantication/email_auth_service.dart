import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthService {
  static Future<UserCredential?> signupUser(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      log("Sign Up Error==>> ${e.message}");
    }
    return null;
  }

  static Future<UserCredential?> loginUser(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      log("Sign In Error==>> ${e.message}");
    }
    return null;
  }

  static Future logoutUser() async {
    try {
      log(FirebaseAuth.instance.currentUser!.email.toString());
      log(FirebaseAuth.instance.currentUser!.uid);
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      log("Sign Out Error==>> ${e.message}");
    }
  }
}
