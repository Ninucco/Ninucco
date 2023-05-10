import 'package:flutter/material.dart';

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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

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
                      // child: Hero(
                      //   tag: 'signInWithGoogleButton',
                      //   child: FloatingActionButton.extended(
                      //     onPressed: () async {
                      //       final navigator = Navigator.of(context);
                      //       await authProvider.signIn();
                      //       navigator.pushNamed('/');
                      //     },
                      //     label: const Text(
                      //       'Sign in with Google',
                      //       style: TextStyle(fontSize: 18),
                      //     ),
                      //     icon: Image.asset(
                      //       'assets/icons/google_logo.png',
                      //       height: 20,
                      //     ),
                      //     backgroundColor: Colors.black,
                      //   ),
                      child: ElevatedButton(
                        onPressed: () async {
                          // final navigator = Navigator.of(context);
                          await authProvider.signIn();
                          // navigator.pushNamed(
                          //   '/',
                          // );
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
                      )),
                ),
              ],
            )));
  }
}
