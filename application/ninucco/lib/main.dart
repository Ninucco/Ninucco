import 'package:flutter/material.dart';
import 'package:ninucco/providers/test_provider.dart';
import 'package:provider/provider.dart';
import 'package:ninucco/screens/ranking/ranking_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ninucco',
        home: ChangeNotifierProvider(
          create: (_) => TestProvider(),
          child: const RankingScreen(),
        ));
  }
}
