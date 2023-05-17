import 'package:flutter/material.dart';
import 'package:ninucco/navigators/global_routes.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: ((settings) {
        return globalRoutes(settings);
      }),
    );
  }
}
