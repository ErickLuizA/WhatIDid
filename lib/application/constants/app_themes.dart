import 'package:flutter/material.dart';

class AppThemes {
  static final dark = ThemeData(
    primaryColor: Color(0XFF546E7A),
    primaryColorLight: Color(0XFF819CA9),
    primaryColorDark: Color(0XFF29434E),
    accentColor: Color(0XFFFFAB91),
    primaryTextTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.white10,
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
      headline5: TextStyle(
        color: Colors.white10,
        fontSize: 18,
      ),
      headline6: TextStyle(
        color: Colors.white10,
        fontSize: 20,
      ),
    ),
    accentTextTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black12,
        fontSize: 16,
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0XFF546E7A),
    ),
    accentIconTheme: IconThemeData(
      color: Colors.grey,
      size: 14,
    ),
  );

  static final light = ThemeData(
    primaryColor: Colors.blueGrey[200],
    primaryColorLight: Colors.blueGrey[100],
    primaryColorDark: Colors.blueGrey[300],
    accentColor: Colors.pink[200],
    primaryTextTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black12,
        fontSize: 16,
      ),
      bodyText2: TextStyle(
        color: Colors.grey[600],
        fontSize: 14,
      ),
      headline5: TextStyle(
        color: Colors.black12,
        fontSize: 18,
      ),
      headline6: TextStyle(
        color: Colors.black12,
        fontSize: 20,
      ),
    ),
    accentTextTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.black12,
        fontSize: 16,
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0XFF546E7A),
    ),
    accentIconTheme: IconThemeData(
      color: Colors.grey,
      size: 14,
    ),
  );
}
