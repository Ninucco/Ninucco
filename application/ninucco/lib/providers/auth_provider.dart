import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ninucco/models/member_model.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;
  MemberModel? _member;
  MemberModel? get member => _member;

  void setUser(User? user) async {
    notifyListeners();
    _user = user;
  }

  void setMember(MemberModel? member) {
    notifyListeners();
    _member = member;
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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signIn() async {
    try {
      await signInWithGoogle();
      setUser(FirebaseAuth.instance.currentUser);
    } catch (error) {
      // Handle the error here
      debugPrint('Failed to sign in with Google: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      setUser(null);
    } catch (error) {
      // Handle the error here
      debugPrint('Failed to sign in with Google: $error');
    }
  }
}
