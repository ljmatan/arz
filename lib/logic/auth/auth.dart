import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthAPI {
  static UserCredential? _instance;
  static UserCredential? get instance => _instance;

  static Future<UserCredential?> loginEmail(
      String email, String password) async {
    try {
      _instance = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return _instance;
    } catch (e) {
      print(e);
    }
  }

  /*
  static final GoogleSignIn _googleLogin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static GoogleSignInAccount? _googleAccount;

  static Future googleLogin() async {
    try {
      _googleAccount = await _googleLogin.signIn();
      if (_googleAccount != null) print('aaa');
    } catch (error) {
      print(error);
    }

    return false;
  }
  */
}
