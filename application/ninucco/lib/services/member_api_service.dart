import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ninucco/models/member_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MemberApiService {
  static const String baseUrl = "https://dummyjson.com";

  static Future<MemberModel> memberRegist(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userToken = _auth.currentUser?.refreshToken;
    final uid = _auth.currentUser?.uid;
    final email = _auth.currentUser?.email;
    final photoURL = _auth.currentUser?.photoURL;

    Map<String, String?> data = {
      'id': uid,
      'nickname': email,
      'url': photoURL,
    };

    final url = Uri.parse('$baseUrl/member/regist');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: json.encode(data));

    if (response.statusCode == 200) {
      final member = jsonDecode(response.body)["data"];
      final instance = MemberModel.fromJson(member);
      authProvider.setMember(instance);
      return instance;
    }
    throw Error();
  }

  static Future<MemberModel> memberLogin(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userToken = _auth.currentUser?.refreshToken;
    final uid = _auth.currentUser?.uid;

    Map<String, String?> data = {
      'id': uid,
    };

    final url = Uri.parse('$baseUrl/member/login');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: json.encode(data));

    if (response.statusCode == 200) {
      final loginInfo = jsonDecode(response.body)["data"];
      final instance = MemberModel.fromJson(loginInfo);
      authProvider.setMember(instance);
      return instance;
    }
    throw Error();
  }

  static Future<MemberModel> getFriendList(BuildContext context) async {
    final userToken = _auth.currentUser?.refreshToken;
    final uid = _auth.currentUser?.uid;

    Map<String, String?> data = {
      'id': uid,
    };

    final url = Uri.parse('$baseUrl/member/friend-list');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: json.encode(data));

    if (response.statusCode == 200) {
      final loginInfo = jsonDecode(response.body)["data"];
      final instance = MemberModel.fromJson(loginInfo);
      return instance;
    }
    throw Error();
  }
}
