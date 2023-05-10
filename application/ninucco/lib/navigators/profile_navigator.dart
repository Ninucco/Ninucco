import 'package:flutter/material.dart';
import 'package:ninucco/screens/home/category.dart';
import 'package:ninucco/screens/home/face_scan.dart';
import 'package:ninucco/screens/home/home.dart';
import 'package:ninucco/screens/home/scan_result.dart';
import 'package:ninucco/screens/home/search.dart';
import 'package:ninucco/screens/login/login_screen.dart';
import 'package:ninucco/screens/profile/my_profile.dart';
import 'package:ninucco/screens/profile/profile.dart';
import 'package:ninucco/screens/profile/profile_scan_result.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/MyProfile',
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case "/":
                return const HomeScreen();
              case "/FaceScan":
                return FaceScan(settings: settings);
              case "/ScanResult":
                return ScanResult(settings: settings);
              case "/Search":
                return SearchScreen(settings: settings);
              case "/Login":
                return const LoginScreen();
              case "/Category":
                return const CategoryScreen();
              case "/Profile":
                return ProfileScreen(settings: settings);
              case "/MyProfile":
                return const MyProfileScreen();
              case "/ProfileScanList":
                return ProfileScanResult(settings: settings);
              default:
                return const Placeholder();
            }
          },
        );
      }),
    );
  }
}
