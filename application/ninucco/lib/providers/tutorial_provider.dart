import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  bool? _isPassTutorial;
  bool? get tutorialStatus => _isPassTutorial;

  TutorialProvider() {
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _isPassTutorial = _prefs.getBool('isPassTutorial') ?? false;
    notifyListeners();
  }

  void setIsPassTutorial(bool isPassTutorial) async {
    notifyListeners();
    await _prefs.setBool('isPassTutorial', isPassTutorial);
    _isPassTutorial = isPassTutorial;
    // print(_prefs.getBool('isPassTutorial'));
  }

  Future<void> passTutorial() async {
    try {
      setIsPassTutorial(true);
    } catch (error) {
      debugPrint('SharedPreferences Error');
    }
  }
}
