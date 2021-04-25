import 'package:flutter/material.dart';
import 'package:whatidid/presentation/bottom_navigation.dart';
import 'package:whatidid/presentation/screens/splash/splash_screen.dart';

class AppRoutes {
  static const SPLASH = 'SPLASH';
  static const HOME = 'HOME';
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
};
