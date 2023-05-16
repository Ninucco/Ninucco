import 'package:flutter/material.dart';
import 'package:ninucco/screens/battle/battle_all_screen.dart';
import 'package:ninucco/screens/battle/battle_approve.dart';
import 'package:ninucco/screens/battle/battle_create_detail_screen.dart';
import 'package:ninucco/screens/battle/battle_create_screen.dart';
import 'package:ninucco/screens/battle/battle_detail_screen.dart';
import 'package:ninucco/screens/battle/battle_friend_search.dart';
import 'package:ninucco/screens/home/category.dart';
import 'package:ninucco/screens/home/face_scan.dart';
import 'package:ninucco/screens/home/home.dart';
import 'package:ninucco/screens/home/scan_result.dart';
import 'package:ninucco/screens/home/search.dart';
import 'package:ninucco/screens/login/login_screen.dart';
import 'package:ninucco/screens/profile/my_profile.dart';
import 'package:ninucco/screens/profile/profile.dart';
import 'package:ninucco/screens/profile/profile_battles_list.dart';
import 'package:ninucco/screens/profile/profile_image_picker.dart';
import 'package:ninucco/screens/profile/profile_scan_result.dart';
import 'package:ninucco/screens/profile/profile_settings.dart';
import 'package:ninucco/screens/profile/received_battles.dart';

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
              case "/ProfileSettings":
                return ProfileSettings(settings: settings);
              case "/ProfileBattleList":
                return ProfileBattlesList(settings: settings);
              case "/ProfileImagePicker":
                return ProfileImagePicker(settings: settings);
              case "/ProfileReceivedBattle":
                return ReceivedBattles(settings: settings);
              case "/BattleApprove":
                return BattleApprove(settings: settings);
              case "/BattleAllScreen":
                return const BattleActiveScreen();
              case "/BattleDetailScreen":
                return BattleDetailScreen(settings: settings);
              case "/BattleCreateScreen":
                return const BattleCreateScreen();
              case "/BattleCreateDetailScreen":
                return BattleCreateDetailScreen(settings: settings);
              case "/BattleFriendSearch":
                return BattleFriendSearchScreen(settings: settings);

              default:
                return const Placeholder();
            }
          },
        );
      }),
    );
  }
}
