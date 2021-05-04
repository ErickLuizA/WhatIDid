import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const LANG = 'LANG';

class LanguageController extends ChangeNotifier {
  late SharedPreferences _sharedPreferences;

  Locale? _currentLocale;
  Locale? get currentLocale => _currentLocale;

  Future<void> loadLocale() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    final storageLanguage = _sharedPreferences.getString(LANG);

    if (storageLanguage != null) {
      final storageLangArray = storageLanguage.split(',');

      _currentLocale = Locale(storageLangArray[0], storageLangArray[1]);
    }

    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    _currentLocale = newLocale;

    await _sharedPreferences.setString(
      LANG,
      "${newLocale.languageCode},${newLocale.countryCode}",
    );

    notifyListeners();
  }
}

final languageControllerProvider = ChangeNotifierProvider(
  (ref) => LanguageController(),
);
