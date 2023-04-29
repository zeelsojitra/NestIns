import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

String? profile_name, profile_email; //profile_image,

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
      var _user = authResult.user;
      print("User Name: ${_user?.displayName}");
      print("User photo ${_user?.photoURL}");
      print("User Email ${_user?.email}");
      profile_name = _user!.displayName;
      // profile_image = _user!.photoURL;
      profile_email = _user!.email;
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      print("GOOGLE AUTH ERROR==>>${e.message}");
    }
  }

  static googleSignOut() async {
    GoogleSignIn().signOut();
  }
}
