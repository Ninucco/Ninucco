import 'package:flutter/material.dart';
import 'package:ninucco/screens/screen_a.dart';
import 'package:ninucco/screens/screen_b.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key, required this.tabIndex});
  final int tabIndex;
  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      "/": (context) => ScreenA(
            tabIndex: tabIndex, //이거 말고는 변한게 없음!
          ),
      "/ScreenB": (context) => ScreenB(
            tabIndex: tabIndex, //이거 말고는 변한게 없음!
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilder(context);
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilder[settings.name!]!(context),
        );
      }),
    );
  }
}
