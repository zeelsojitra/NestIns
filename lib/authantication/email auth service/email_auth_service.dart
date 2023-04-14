import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthServices {
  static Future<UserCredential?> signUpUser(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('SIGN UP ERRRO++>>${e.message}');
    }
  }

  static Future<UserCredential?> loginUser(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('SIGN IN ERRRO++>>${e.message}');
    }
  }

  static Future logOut() async {
    try {
      print(FirebaseAuth.instance.currentUser!.email);
      print(FirebaseAuth.instance.currentUser!.uid);
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print('SIGN OUT ERRRO++>>${e.message}');
    }
  }
}
