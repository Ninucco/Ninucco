import 'package:flutter/material.dart';
import 'package:ninucco/navigators/global_routes.dart';

class RankNavigator extends StatelessWidget {
  const RankNavigator({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/Ranking',
      onGenerateRoute: ((settings) {
        return globalRoutes(settings);
      }),
    );
  }
}
