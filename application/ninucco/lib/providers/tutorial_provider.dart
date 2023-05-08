import 'package:flutter/material.dart';

class TutorialProvider with ChangeNotifier {
  bool _isPassTutorial = false;
  bool get showTutorial => _isPassTutorial;

  void hideTutorial() {
    _isPassTutorial = true;
    notifyListeners();
  }
}
