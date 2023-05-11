import 'package:flutter/material.dart';
import 'package:ninucco/screens/battle/battle_all_screen.dart';
import 'package:ninucco/screens/battle/battle_create_detail_screen.dart';
import 'package:ninucco/screens/battle/battle_create_screen.dart';
import 'package:ninucco/screens/battle/battle_detail_screen.dart';
import 'package:ninucco/screens/battle/battle_friend_search.dart';

class BattleNavigator extends StatelessWidget {
  const BattleNavigator({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/BattleAllScreen',
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case "/BattleAllScreen":
                return BattleAllScreen();
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
