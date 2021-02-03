part of 'services.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookLogin();
  bool _isSigningIn;

  SignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  //GOOGLE
  Future signInWithGoogle() async {
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

  void signOutWithGoogle() async {
    isSigningIn = true;

    try {
      isSigningIn = false;
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    } on Exception{
      FirebaseAuth.instance.signOut();
    } 
  }

  //FACEBOOK
  Future signInWithFacebook() async{
    FacebookLoginResult result = await facebookSignIn.logIn(["email"]);
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("You have cancelled the sign in process");
        break;
      case FacebookLoginStatus.error:
        print( FacebookLoginStatus.error.toString());
        break;
      case FacebookLoginStatus.loggedIn:
        await signInWithFacebookHandler(result);
        break;
      default:
    }
  }

  Future signInWithFacebookHandler(FacebookLoginResult _result) async {
    isSigningIn = true;
      FacebookAccessToken _accessToken = _result.accessToken;
      AuthCredential _credential = FacebookAuthProvider.credential(_accessToken.token);
      await FirebaseAuth.instance.signInWithCredential(_credential);
    isSigningIn = false;
  }
}
