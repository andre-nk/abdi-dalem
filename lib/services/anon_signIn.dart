part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User firebaseUser = result.user;
      return firebaseUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> signOutAnonymously() async{
    _auth.signOut();
  }
}
