import 'package:flutter/material.dart';
import 'package:whatidid/presentation/bottom_navigation.dart';
import 'package:whatidid/presentation/screens/create/create_screen.dart';
import 'package:whatidid/presentation/screens/entrie/entrie_screen.dart';
import 'package:whatidid/presentation/screens/search/search_screen.dart';
import 'package:whatidid/presentation/screens/splash/splash_screen.dart';

class AppRoutes {
  static const SPLASH = 'SPLASH';
  static const HOME = 'HOME';
  static const SEARCH = 'SEARCH';
  static const CREATE = 'CREATE';
  static const ENTRIE = 'ENTRIE';
  static const CATEGORY = 'CATEGORY';
}

Map<String, Route Function(Map<String, dynamic> args)> routes = {
  AppRoutes.SPLASH: (Map<String, dynamic> args) {
    return MaterialPageRoute(
      builder: (context) {
        return SplashScreen();
      },
    );
  },
  AppRoutes.HOME: (Map<String, dynamic> args) {
    return MaterialPageRoute(
      builder: (context) {
        return BottomNavigation();
      },
    );
  },
  AppRoutes.CREATE: (Map<String, dynamic> args) {
    return MaterialPageRoute(
      builder: (context) {
        return CreateScreen(
          category: args['category'],
        );
      },
    );
  },
  AppRoutes.SEARCH: (Map<String, dynamic> args) {
    return MaterialPageRoute(
      builder: (context) {
        return SearchScreen(
          category: args['category'],
        );
      },
    );
  },
  AppRoutes.ENTRIE: (Map<String, dynamic> args) {
    return MaterialPageRoute(
      builder: (context) {
        return EntrieScreen(
          args['entrie'],
        );
      },
    );
  },
};
