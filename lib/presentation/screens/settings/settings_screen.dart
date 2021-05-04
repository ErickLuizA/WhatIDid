import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/application/providers/controllers/home_category_controller.dart';
import 'package:whatidid/application/providers/controllers/language_controller.dart';
import 'package:whatidid/application/providers/controllers/theme_controller.dart';
import 'package:whatidid/data/daos/categories_dao.dart';
import 'package:whatidid/domain/models/category.dart';
import 'package:whatidid/presentation/app_localizations.dart';

import 'widgets/button_widget.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.read(themeControllerProvider).toggleTheme();
            },
            child: ButtonWidget(
              child: Row(
                children: [
                  Icon(Icons.brightness_6),
                  SizedBox(width: 5),
                  Text(AppLocalizations.of(context).translate("dark_theme")),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          ButtonWidget(
            child: PopupMenuButton(
              color: Theme.of(context).primaryColorLight,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text("PT-BR"),
                    value: Locale("pt", "BR"),
                  ),
                  PopupMenuItem(
                    child: Text("EN-US"),
                    value: Locale("en", "US"),
                  ),
                ];
              },
              onSelected: (Locale value) {
                context.read(languageControllerProvider).setLocale(value);
              },
              child: Row(
                children: [
                  Icon(Icons.language),
                  SizedBox(width: 5),
                  Text(AppLocalizations.of(context).translate("language")),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder<List<Category>>(
            future: context.read(categoriesDaoProvider).getAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ButtonWidget(
                  child: PopupMenuButton(
                    color: Theme.of(context).primaryColorLight,
                    itemBuilder: (context) {
                      return snapshot.data!
                          .map(
                            (e) => PopupMenuItem(
                              value: e.name,
                              child: Text(e.name),
                            ),
                          )
                          .toList();
                    },
                    onSelected: (String value) {
                      context
                          .read(homeCategoryControllerProvider)
                          .changeHomeCategory(value);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.category),
                        SizedBox(width: 5),
                        Text(
                          AppLocalizations.of(context)
                              .translate("home_category"),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return ButtonWidget(
                  child: PopupMenuButton(
                    color: Theme.of(context).primaryColorLight,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: "Daily",
                          child: Text(
                              AppLocalizations.of(context).translate('daily')),
                        ),
                      ];
                    },
                    onSelected: (String value) {
                      context
                          .read(homeCategoryControllerProvider)
                          .changeHomeCategory(value);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.category),
                        SizedBox(width: 5),
                        Text(
                          AppLocalizations.of(context)
                              .translate("home_category"),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
