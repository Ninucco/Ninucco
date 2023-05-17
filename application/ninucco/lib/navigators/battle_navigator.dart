import 'package:flutter/material.dart';
import 'package:ninucco/navigators/global_routes.dart';

class BattleNavigator extends StatelessWidget {
  const BattleNavigator({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/BattleScreen',
      onGenerateRoute: ((settings) {
        return globalRoutes(settings);
      }),
    );
  }
}
