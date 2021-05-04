import 'package:flutter/material.dart';
import 'package:whatidid/application/constants/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.popAndPushNamed(context, AppRoutes.HOME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "What",
            style: TextStyle(
              fontFamily: 'Sacramento',
              decoration: TextDecoration.none,
              color: Theme.of(context).primaryTextTheme.headline6?.color,
            ),
          ),
          Text(
            "I",
            style: TextStyle(
              fontFamily: 'Sacramento',
              decoration: TextDecoration.none,
              color: Theme.of(context).primaryTextTheme.bodyText1?.color,
            ),
          ),
          Text(
            "Did",
            style: TextStyle(
              fontFamily: 'Sacramento',
              decoration: TextDecoration.none,
              color: Theme.of(context).primaryTextTheme.headline6?.color,
            ),
          ),
        ],
      ),
    );
  }
}
