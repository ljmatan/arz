import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print('$e');
    }
    return false;
  }

  static Future<UserCredential?> createUsingEmail(
      String email, String password) async {
    try {
      _instance = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return _instance;
    } catch (e) {
      print(e);
    }
  }

  static final GoogleSignIn _googleLogin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static GoogleSignInAccount? _googleAccount;

  static Future googleLogin() async {
    try {
      final GoogleSignInAccount? _googleAccount = await _googleLogin.signIn();
      if (_googleAccount != null) return true;
    } catch (e) {
      print(e);
    }

    return false;
  }

  static Future<bool> fbLogin() async {
    try {
      // by default the login method has the next permissions ['email','public_profile']
      AccessToken? accessToken = await FacebookAuth.instance.login();
      print(accessToken?.toJson());
      // get the user data
      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
      return true;
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    }

    return false;
  }
}
