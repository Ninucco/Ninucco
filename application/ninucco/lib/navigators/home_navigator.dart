import 'package:flutter/material.dart';
import 'package:ninucco/screens/home/face_scan.dart';
import 'package:ninucco/screens/home/home.dart';
import 'package:ninucco/screens/home/scan_result.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case "/":
                return const HomePage();
              case "/FaceScan":
                return FaceScan(settings: settings);
              case "/ScanResult":
                return const ScanResult();
              default:
                return const Placeholder();
            }
          },
        );
      }),
    );
  }
}
