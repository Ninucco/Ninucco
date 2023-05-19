import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninucco/navigators/battle_navigator.dart';
import 'package:ninucco/navigators/center_navigator.dart';
import 'package:ninucco/navigators/home_navigator.dart';
import 'package:ninucco/navigators/profile_navigator.dart';
import 'package:ninucco/navigators/rank_navigator.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:ninucco/providers/test_provider.dart';
import 'package:ninucco/providers/tutorial_provider.dart';
import 'package:ninucco/screens/loading/loading_screen.dart';

import 'package:ninucco/screens/login/login_screen.dart';
import 'package:ninucco/services/member_api_service.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:ninucco/screens/tutorial/tutorial_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 50;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  KakaoSdk.init(
    nativeAppKey: 'ce38806c8fa40331c80fc9471e75483e',
    javaScriptAppKey: 'c04733f3dbfc4f5a1e27c6e4217af2ba',
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TestProvider()),
          ChangeNotifierProvider(create: (_) => NavProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => TutorialProvider()),
        ],
        child: MaterialApp(
          title: 'ninucco',
          theme: ThemeData(fontFamily: 'NexonGothic').copyWith(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: const Color(0xff9BA0FC),
                ),
          ),
          home: Consumer<TutorialProvider>(
            builder: (context, tutorialProvider, _) {
              if (tutorialProvider.tutorialStatus == null) {
                return const LoadingScreen();
              } else if (tutorialProvider.tutorialStatus!) {
                return Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    if (authProvider.loginStatus) {
                      return const Layout();
                    } else {
                      return const LoginScreen();
                    }
                  },
                );
              } else {
                return const TutorialScreen();
              }
            },
          ),
        ));
  }
}

class Layout extends StatefulWidget {
  const Layout({
    super.key,
  });

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      // authProvider.signOut();

      final apiService = MemberApiService(authProvider);
      if (authProvider.member == null && _auth.currentUser?.uid != null) {
        MemberApiService.login(apiService);
      }
    });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('앱을 나가시겠습니까?'),
            content: const Text(' 정말...? 😥'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('아니요'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('네'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    NavProvider navProvider = Provider.of<NavProvider>(context);

    bool showFloatButton = Provider.of<NavProvider>(context).show &&
        MediaQuery.of(context).viewInsets.bottom == 0;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
            Offstage(
              offstage: navProvider.index != 4,
              child: const CenterNavigator(tabIndex: 4),
            ),
          ],
        ),
        // resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            width: 64,
            height: 72,
            child: !showFloatButton
                ? null
                : FloatingActionButton(
                    backgroundColor: const Color(0xff7E81FB),
                    onPressed: () => navProvider.to(4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/icons/ninucco.png',
                      ),
                    ),
                  ),
          ),
        ),
        bottomNavigationBar:
            Provider.of<NavProvider>(context).show ? const BottomNav() : null,
      ),
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
                    BottomNavLabel(
                      text: "HOME",
                      selected: navProvider.index == 0,
                    )
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
                  BottomNavLabel(
                    text: "RANK",
                    selected: navProvider.index == 1,
                  )
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
                  BottomNavLabel(
                    text: "BATTLE",
                    selected: navProvider.index == 2,
                  )
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
                  BottomNavLabel(
                    text: "PROFILE",
                    selected: navProvider.index == 3,
                  )
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
  final bool selected;
  const BottomNavLabel({
    super.key,
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
