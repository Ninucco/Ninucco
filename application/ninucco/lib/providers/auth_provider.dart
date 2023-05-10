import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ninucco/models/member_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MemberModel? _member;
  MemberModel? get member => _member;

  late bool _isLogin = (_auth.currentUser == null) ? false : true;
  bool get loginStatus => _isLogin;

  void setMember(MemberModel? member) {
    notifyListeners();
    _member = member;
  }

  void setLoginStatus(bool status) {
    notifyListeners();
    _isLogin = status;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  Future<void> signIn() async {
    try {
      await signInWithGoogle();
      setLoginStatus(true);
    } catch (error) {
      // Handle the error here
      debugPrint('Failed to sign in with Google: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      setMember(null);
      setLoginStatus(false);
    } catch (error) {
      // Handle the error here
      debugPrint('Failed to sign in with Google: $error');
    }
  }
}
