import 'package:flutter/material.dart';
import 'package:ninucco/providers/auth_provider.dart';
// import 'package:ninucco/screens/login/login_google_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  // final Future<List<UserRankInfoModel>> userRanks =
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final authProvider = AuthProvider();

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
                          await authProvider.signInWithGoogle();
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
