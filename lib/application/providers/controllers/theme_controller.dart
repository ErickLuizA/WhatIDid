import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const DARK = 'DARK';

class ThemeController extends ChangeNotifier {
  late SharedPreferences _sharedPreferences;

  bool _isDark = true;
  bool get isDark => _isDark;

  Future<void> load() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    bool storageTheme = _sharedPreferences.getBool(DARK) ?? true;

    _isDark = storageTheme;

    notifyListeners();
  }

  void toggleTheme() {
    final newValue = _isDark ? false : true;

    _sharedPreferences.setBool(DARK, newValue);
    _isDark = newValue;

    notifyListeners();
  }
}

final themeControllerProvider = ChangeNotifierProvider(
  (ref) => ThemeController(),
);
