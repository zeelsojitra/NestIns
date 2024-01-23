import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthServices {
  static Future<UserCredential?> signUpUser(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log('SIGN UP ERRRO++>>${e.message}');
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
      log('SIGN IN ERRRO++>>${e.message}');
    }
    return null;
  }

  static Future logOut() async {
    try {
      log(FirebaseAuth.instance.currentUser!.email.toString());
      log(FirebaseAuth.instance.currentUser!.uid);
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      log('SIGN OUT ERRRO++>>${e.message}');
    }
  }
}
