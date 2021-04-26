import 'package:flutter/material.dart';
import 'package:whatidid/application/constants/app_routes.dart';

class FabWidget extends StatelessWidget {
  final String? category;

  const FabWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Theme.of(context).primaryTextTheme.bodyText1?.color,
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.CREATE, arguments: {
          "category": category,
        });
      },
      child: Icon(Icons.add),
    );
  }
}
