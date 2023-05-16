import 'package:flutter/material.dart';
import 'package:ninucco/navigators/global_routes.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/MyProfile',
      onGenerateRoute: ((settings) {
        return globalRoutes(settings);
      }),
    );
  }
}
