import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ninucco/models/member_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get getFireBaseAuth => _auth;

  late bool _isLogin = (_auth.currentUser == null) ? false : true;
  bool get loginStatus => _isLogin;

  MemberModel? _member;
  MemberModel? get member => _member;
  bool _update = false;

  void setUpdate() {
    notifyListeners();
    _update = !_update;
  }

  get update => _update;

  void setMember(MemberModel? member) {
    notifyListeners();
    _member = member;
  }

  void setLoginStatus(bool status) {
    notifyListeners();
    _isLogin = status;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<void> signIn() async {
    try {
      await signInWithGoogle();
      setLoginStatus(true);
    } on PlatformException catch (error) {
      if (error.code == 'sign_in_canceled') {
        debugPrint('Google sign in was canceled');
      }
    } catch (error) {
      debugPrint('Failed to sign in with Google: $error');
    }
  }

  Future<UserCredential> signInAnonymous() async {
    UserCredential data = await _auth.signInAnonymously();
    return data;
  }

  Future<void> signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    String providerId = _auth.currentUser?.providerData.isNotEmpty ?? false
        ? _auth.currentUser!.providerData[0].providerId
        : '';
    try {
      // 구글 로그인으로 진행했다면 구글 로그인 정보 초기화
      if (providerId == 'google.com') {
        await _auth.signOut();
        await googleSignIn.disconnect();
        // 그 외에는 일반 로그아웃
      } else {
        await _auth.signOut();
      }
      setMember(null);
      setLoginStatus(false);
    } catch (error) {
      // Handle the error here
      debugPrint('Failed to sign in with Google: $error');
    }
  }

  Future<void> convertAnonymousToGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      _auth.currentUser?.linkWithCredential(credential);
    } on PlatformException catch (error) {
      if (error.code == 'sign_in_canceled') {
        debugPrint('Google sign in was canceled');
      } else if (error.code == 'credential-already-in-use') {
        debugPrint('Google Account Already Exist');
        return;
      }
    } catch (error) {
      debugPrint('Failed to convert with Google: $error');
    }
  }
}
