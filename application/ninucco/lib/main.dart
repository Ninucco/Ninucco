import 'package:flutter/material.dart';
import 'package:ninucco/providers/nav_provider.dart';
import 'package:ninucco/providers/test_provider.dart';
import 'package:ninucco/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
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
        ],
        child: const Layout(),
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
    return Scaffold(
      body: const Home(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: const Color(0xff7E81FB),
        onPressed: () {},
        child: Image.asset('assets/icons/ninucco.png'),
      ),
      bottomNavigationBar: const BottomNav(),
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
