import 'package:flutter/material.dart';
import 'package:ninucco/navigators/global_routes.dart';

class CenterNavigator extends StatelessWidget {
  const CenterNavigator({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/Category',
      onGenerateRoute: ((settings) {
        return globalRoutes(settings);
      }),
    );
  }
}
