import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  int _index = 0;
  bool _show = true;

  int get index => _index;
  bool get show => _show;
  void showBottomNav() {
    _show = true;
    notifyListeners();
  }

  void hideBottomNav() {
    _show = false;
    notifyListeners();
  }

  void to(int to) {
    _index = to;
    notifyListeners();
  }
}
