import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ninucco/models/member_model.dart';
import 'package:ninucco/services/member_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ninucco/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  // final RouteSettings settings;
  const LoginScreen({
    super.key,
    // required this.settings,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    // final apiService = MemberApiService(authProvider);

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
          title: const Text('Sign In'),
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/bg/bg.png'),
              fit: BoxFit.cover,
            )),
            padding: const EdgeInsets.all(16),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 35)),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/logo.png'),
                      ),
                    ),
                    height: 50,
                    margin: const EdgeInsets.all(16),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 12),
                    child: const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 12),
                    child: const Text(
                      "Sign in to continue",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
                SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: () async {
                        var userData = await authProvider.signInWithGoogle();
                        var user = userData.user;
                        String baseUrl = "https://k8a605.p.ssafy.io/api/member";
                        if (user?.uid == null) {
                          return;
                        }
                        if (await MemberApiService.checkRegisted(user!.uid)) {
                          // 로그인
                          var url = Uri.parse('$baseUrl/login');
                          Map<String, String?> req = {
                            'id': user.uid,
                          };
                          var response = await http.post(
                            url,
                            headers: {'Content-Type': 'application/json'},
                            body: json.encode(req),
                          );
                          final member = jsonDecode(response.body)['data'];
                          final instance = MemberModel.fromJson(member);
                          authProvider.setMember(instance);
                        } else {
                          // 회원가입
                          var url = Uri.parse('$baseUrl/regist');

                          Map<String, String?> data = {
                            'id': user.uid,
                            'nickname': user.email,
                            'url':
                                'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default.png',
                          };

                          var response = await http.post(url,
                              headers: {'Content-Type': 'application/json'},
                              body: json.encode(data));

                          final member = jsonDecode(response.body)['data'];
                          final instance = MemberModel.fromJson(member);
                          authProvider.setMember(instance);
                        }
                        authProvider.setLoginStatus(true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sign in with Google',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/icons/google_logo.png',
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      onPressed: () async {
                        var userData = await authProvider.signInAnonymous();
                        var user = userData.user;

                        String baseUrl = "https://k8a605.p.ssafy.io/api/member";
                        var url = Uri.parse('$baseUrl/regist');

                        Map<String, String?> data = {
                          'id': user?.uid,
                          'nickname': user?.email,
                          'url':
                              'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default.png',
                        };

                        var response = await http.post(url,
                            headers: {'Content-Type': 'application/json'},
                            body: json.encode(data));

                        final member = jsonDecode(response.body)['data'];
                        final instance = MemberModel.fromJson(member);
                        authProvider.setMember(instance);
                        authProvider.setLoginStatus(true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 20)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Just Start',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
