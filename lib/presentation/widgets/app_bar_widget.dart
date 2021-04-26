import 'package:flutter/material.dart';
import 'package:whatidid/application/constants/app_routes.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    required String title,
    String? category,
    required BuildContext context,
    required bool showMenu,
    required bool showSearch,
  }) : super(
          title: Text(
            title,
            style: Theme.of(context).primaryTextTheme.bodyText1,
          ),
          actions: [
            if (showMenu)
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text('hello'),
                    ),
                  ];
                },
              ),
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
