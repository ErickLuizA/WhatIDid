import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatidid/application/constants/app_routes.dart';
import 'package:whatidid/application/constants/app_themes.dart';
import 'package:whatidid/application/providers/controllers/home_category_controller.dart';
import 'package:whatidid/application/providers/controllers/language_controller.dart';
import 'package:whatidid/application/providers/controllers/theme_controller.dart';

import 'app_localizations.dart';

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  @override
  void initState() {
    super.initState();

    context.read(homeCategoryControllerProvider).load();
    context.read(themeControllerProvider).load();
    context.read(languageControllerProvider).loadLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final isDark = watch(themeControllerProvider).isDark;
        final currentLocale = watch(languageControllerProvider).currentLocale;

        return MaterialApp(
          title: "WhatIDid",
          theme: isDark ? AppThemes.dark : AppThemes.light,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            LocalizationDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('pt', 'BR'),
          ],
          locale: currentLocale,
          initialRoute: AppRoutes.SPLASH,
          onGenerateRoute: onGenerateRoute,
        );
      },
    );
  }
}

Route onGenerateRoute(RouteSettings routeSettings) {
  final args = routeSettings.arguments as Map<String, dynamic>?;

  return routes[routeSettings.name]!(args ?? Map());
}
