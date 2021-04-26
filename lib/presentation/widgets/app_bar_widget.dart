import 'package:flutter/material.dart';
import 'package:whatidid/application/constants/app_routes.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    required String title,
    String? category,
    required BuildContext context,
    required int index,
  }) : super(
          title: Text(
            title,
            style: Theme.of(context).primaryTextTheme.bodyText1,
          ),
          actions: [
            if (index == 2)
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text('hello'),
                    ),
                  ];
                },
              ),
            if (index == 0 || index == 1)
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.SEARCH, arguments: {
                    "category": category,
                  });
                },
              ),
            SizedBox(width: 10),
          ],
        );
}
