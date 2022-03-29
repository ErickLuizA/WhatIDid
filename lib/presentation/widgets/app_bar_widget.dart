import 'package:flutter/material.dart';
import 'package:whatidid/application/constants/app_routes.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    required String title,
    String? category,
    required BuildContext context,
    required bool showSearch,
  }) : super(
          title: Text(
            title,
            style: Theme.of(context).primaryTextTheme.headline5,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            if (showSearch)
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.SEARCH,
                    arguments: {
                      "category": category,
                    },
                  );
                },
              ),
            SizedBox(width: 10),
          ],
        );
}
