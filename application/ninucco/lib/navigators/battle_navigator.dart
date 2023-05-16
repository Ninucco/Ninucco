import 'package:flutter/material.dart';
import 'package:ninucco/screens/battle/battle_create_detail_screen.dart';
import 'package:ninucco/screens/battle/battle_create_screen.dart';
import 'package:ninucco/screens/battle/battle_detail_screen.dart';
import 'package:ninucco/screens/battle/battle_friend_search.dart';
import 'package:ninucco/screens/battle/battle_screen.dart';
import 'package:ninucco/screens/profile/profile.dart';

class BattleNavigator extends StatelessWidget {
  const BattleNavigator({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/BattleScreen',
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case "/BattleScreen":
                return const BattleScreen();
              case "/BattleDetailScreen":
                return BattleDetailScreen(settings: settings);
              case "/BattleCreateScreen":
                return const BattleCreateScreen();
              case "/BattleCreateDetailScreen":
                return BattleCreateDetailScreen(settings: settings);
              case "/BattleFriendSearch":
                return BattleFriendSearchScreen(settings: settings);
              case "/Profile":
                return ProfileScreen(settings: settings);
              default:
                return const Placeholder();
            }
          },
        );
      }),
    );
  }
}
