import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ninucco/models/member_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MemberApiService {
  static const String baseUrl = "https://k8a605.p.ssafy.io/api/member";

  static Future<MemberModel> regist(BuildContext context) async {
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

    final url = Uri.parse('$baseUrl/regist');
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

  static Future<MemberModel> login(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userToken = _auth.currentUser?.refreshToken;
    final uid = _auth.currentUser?.uid;

    Map<String, String?> data = {
      'id': uid,
    };

    final url = Uri.parse('$baseUrl/login');
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

  static Future<bool> checkRegisted() async {
    final uid = _auth.currentUser?.uid;

    Map<String, String?> data = {
      'id': uid,
    };

    final url = Uri.parse('$baseUrl/checkRegisted');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data));

    if (response.statusCode == 200) {
      final bool isRegisted = jsonDecode(response.body)["check"];
      return isRegisted;
    }
    throw Error();
  }
}
