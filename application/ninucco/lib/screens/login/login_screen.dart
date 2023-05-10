import 'package:flutter/material.dart';
import 'package:ninucco/providers/tutorial_provider.dart';
import 'package:ninucco/services/member_api_service.dart';

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
    final tutorialProvider = Provider.of<TutorialProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final apiService = MemberApiService(authProvider);

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
                      onPressed: () async => {
                        await authProvider.signIn(),
                        if (await MemberApiService.checkRegisted())
                          {
                            await MemberApiService.login(apiService),
                          }
                        else
                          {
                            await MemberApiService.regist(apiService),
                          },
                        tutorialProvider.setIsPassTutorial(true),
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
                      onPressed: () async => {
                        await authProvider.signInAnonymous(),
                        if (await MemberApiService.checkRegisted())
                          {
                            await MemberApiService.login(apiService),
                          }
                        else
                          {
                            await MemberApiService.regist(apiService),
                          },
                        tutorialProvider.setIsPassTutorial(true),
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
