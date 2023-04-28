import 'package:flutter/material.dart';
import 'package:ninucco/navigators/battle_navigator.dart';
import 'package:ninucco/navigators/home_navigator.dart';
import 'package:ninucco/navigators/profile_navigator.dart';
import 'package:ninucco/navigators/rank_navigator.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:ninucco/providers/test_provider.dart';
import 'package:provider/provider.dart';
import 'package:ninucco/screens/login/login_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ninucco',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TestProvider()),
          ChangeNotifierProvider(create: (_) => NavProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const LoginScreen(),
      ),
    );
  }
}

class Layout extends StatelessWidget {
  const Layout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavProvider navProvider = Provider.of<NavProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: navProvider.index != 0,
            child: const HomeNavigator(tabIndex: 0),
          ),
          Offstage(
            offstage: navProvider.index != 1,
            child: const RankNavigator(tabIndex: 1),
          ),
          Offstage(
            offstage: navProvider.index != 2,
            child: const BattleNavigator(tabIndex: 2),
          ),
          Offstage(
            offstage: navProvider.index != 3,
            child: const ProfileNavigator(tabIndex: 3),
          ),
        ],
      ),
      // resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Provider.of<NavProvider>(context).show &&
              MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                width: 64,
                height: 72,
                child: FloatingActionButton(
                  backgroundColor: const Color(0xff7E81FB),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/ninucco.png',
                    ),
                  ),
                ),
              ),
            )
          : null,
      bottomNavigationBar:
          Provider.of<NavProvider>(context).show ? const BottomNav() : null,
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavProvider navProvider = Provider.of<NavProvider>(context);

    return BottomAppBar(
      elevation: 0,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
        decoration: const BoxDecoration(
            color: Color(0xff9C9EFE),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => navProvider.to(0),
              child: AnimatedContainer(
                width: 50,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BottomNavIcon(
                      url: 'assets/icons/home',
                      selected: navProvider.index == 0,
                    ),
                    const BottomNavLabel(text: "HOME")
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => navProvider.to(1),
              child: AnimatedContainer(
                width: 50,
                duration: const Duration(milliseconds: 500),
                child: Column(children: [
                  BottomNavIcon(
                    url: 'assets/icons/rank',
                    selected: navProvider.index == 1,
                  ),
                  const BottomNavLabel(text: "RANK")
                ]),
              ),
            ),
            const SizedBox(width: 60),
            GestureDetector(
              onTap: () => navProvider.to(2),
              child: AnimatedContainer(
                width: 50,
                duration: const Duration(milliseconds: 500),
                child: Column(children: [
                  BottomNavIcon(
                    url: 'assets/icons/battle',
                    selected: navProvider.index == 2,
                  ),
                  const BottomNavLabel(text: "BATTLE")
                ]),
              ),
            ),
            GestureDetector(
              onTap: () => navProvider.to(3),
              child: AnimatedContainer(
                width: 50,
                duration: const Duration(milliseconds: 500),
                child: Column(children: [
                  BottomNavIcon(
                    url: 'assets/icons/profile',
                    selected: navProvider.index == 3,
                  ),
                  const BottomNavLabel(text: "PROFILE")
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavIcon extends StatelessWidget {
  final String url;
  final bool selected;
  const BottomNavIcon({
    super.key,
    required this.url,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      selected ? '${url}_fill.png' : '$url.png',
      color: Colors.white,
    );
  }
}

class BottomNavLabel extends StatelessWidget {
  final String text;
  const BottomNavLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }
}
