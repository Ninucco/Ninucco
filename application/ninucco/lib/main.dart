import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninucco/navigators/battle_navigator.dart';
import 'package:ninucco/navigators/home_navigator.dart';
import 'package:ninucco/navigators/profile_navigator.dart';
import 'package:ninucco/navigators/rank_navigator.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:ninucco/providers/test_provider.dart';
import 'package:ninucco/providers/tutorial_provider.dart';
import 'package:ninucco/screens/loading/loading_screen.dart';
import 'package:ninucco/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:ninucco/screens/tutorial/tutorial_screen_demo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  KakaoSdk.init(
    nativeAppKey: '27f1506378a113d853b372bfa95cc5b1',
    javaScriptAppKey: 'e27d0aa411109cb9f5344f538b5a5282',
  );

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
          home: Consumer2<TutorialProvider, AuthProvider>(
            builder: (context, tutorialProvider, authProvider, _) {
              // print('route by ${tutorialProvider.tutorialStatus}');
              if (tutorialProvider.tutorialStatus == null) {
                return const LoadingScreen(); // 여기에 로딩 추가
              } else if (tutorialProvider.tutorialStatus!) {
                if (authProvider.loginStatus) {
                  return const Layout();
                } else {
                  return const LoginScreen();
                }
              } else {
                return const TutorialScreen();
              }
            },
          ),
        ));
  }
}

class Layout extends StatelessWidget {
  const Layout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavProvider navProvider = Provider.of<NavProvider>(context);

    bool showFloatButton = Provider.of<NavProvider>(context).show &&
        MediaQuery.of(context).viewInsets.bottom == 0;
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
                  onPressed: () {},
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
