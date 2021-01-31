import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future signIn() async {
    isSigningIn = true;

    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        isSigningIn = false;
        return;
      } else {
        final googleAuth = await user.authentication;

        final credentials = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        await FirebaseAuth.instance.signInWithCredential(credentials);

        isSigningIn = false;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void signOut() async {
    isSigningIn = true;

    try {
      isSigningIn = false;
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    } on Exception{
      FirebaseAuth.instance.signOut();
    }
    
  }
}
