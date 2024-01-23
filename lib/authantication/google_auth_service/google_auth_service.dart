import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

String? profileName, profileEmail;

class GoogleAuthService {
  static Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      var user = authResult.user;
      log("User Name: ${user?.displayName}");
      log("User photo ${user?.photoURL}");
      log("User Email ${user?.email}");
      profileName = user!.displayName;
      // profile_image = _user!.photoURL;
      profileEmail = user.email;
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      log("GOOGLE AUTH ERROR==>>${e.message}");
    }
    return null;
  }

  static googleSignOut() async {
    GoogleSignIn().signOut();
  }
}
