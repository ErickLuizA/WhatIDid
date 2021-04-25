import 'package:flutter/material.dart';
import 'package:whatidid/application/constants/app_routes.dart';
import 'package:whatidid/application/constants/app_themes.dart';

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WhatIDid",
      theme: AppThemes.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.SPLASH,
      onGenerateRoute: onGenerateRoute,
    );
  }
}

Route onGenerateRoute(RouteSettings routeSettings) {
  final args = routeSettings.arguments as Map<String, dynamic>?;

  return routes[routeSettings.name]!(args ?? Map());
}
