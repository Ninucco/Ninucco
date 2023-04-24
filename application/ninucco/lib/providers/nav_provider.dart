import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;
  void to(int to) {
    _index = to;
    notifyListeners();
  }
}
