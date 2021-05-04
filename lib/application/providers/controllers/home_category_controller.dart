import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const HOME = 'HOME';

class HomeCategoryController extends ChangeNotifier {
  late SharedPreferences _sharedPreferences;

  late String _category;
  get category => _category;

  Future<void> load() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    final storageCategory = _sharedPreferences.getString(HOME);

    _category = storageCategory ?? 'Daily';

    notifyListeners();
  }

  void changeHomeCategory(String value) {
    _sharedPreferences.setString(HOME, value);

    _category = value;

    notifyListeners();
  }
}

final homeCategoryControllerProvider = ChangeNotifierProvider(
  (ref) => HomeCategoryController(),
);
