import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatidid/application/providers/controllers/home_category_controller.dart';
import 'package:whatidid/presentation/app_localizations.dart';
import 'package:whatidid/presentation/screens/calendar/calendar_screen.dart';
import 'package:whatidid/presentation/screens/categories/categories_screen.dart';
import 'package:whatidid/presentation/screens/home/home_screen.dart';
import 'package:whatidid/presentation/screens/settings/settings_screen.dart';
import 'package:whatidid/presentation/widgets/app_bar_widget.dart';
import 'package:whatidid/presentation/widgets/fab_widget.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  final screens = [
    HomeScreen('Daily'),
    CategoriesScreen(),
    CalendarScreen(),
    SettingsScreen(),
  ];

  List<String> screenNames = ['Home', 'Categories', 'Calendar', 'Settings'];
  List<Icon> icons = [
    Icon(Icons.home),
    Icon(Icons.view_list_outlined),
    Icon(Icons.event),
    Icon(Icons.settings),
  ];
  List<dynamic> categories = ['Daily', null, null, null];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  bool get haveSearch => currentIndex == 0 || currentIndex == 1;
  bool get haveFab => currentIndex == 3 || currentIndex == 2;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final homeCategory = watch(homeCategoryControllerProvider).category;

        screenNames[0] = AppLocalizations.of(context).translate('home');
        screenNames[1] = AppLocalizations.of(context).translate('categories');
        screenNames[2] = AppLocalizations.of(context).translate('calendar');
        screenNames[3] = AppLocalizations.of(context).translate('settings');

        categories[0] = homeCategory;

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBarWidget(
            title: screenNames[currentIndex],
            category: categories[currentIndex],
            context: context,
            showSearch: haveSearch,
          ),
          body: Builder(
            builder: (context) {
              if (currentIndex == 0) {
                return HomeScreen(homeCategory);
              }

              return screens[currentIndex];
            },
          ),
          floatingActionButton:
              haveFab ? null : FabWidget(categories[currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColorLight,
            unselectedIconTheme: Theme.of(context).iconTheme,
            selectedIconTheme: Theme.of(context).primaryIconTheme,
            selectedItemColor: Theme.of(context).primaryColorDark,
            currentIndex: currentIndex,
            onTap: onTap,
            items: [
              for (int i in Iterable.generate(4))
                BottomNavigationBarItem(
                  icon: icons[i],
                  label: screenNames[i],
                ),
            ],
          ),
        );
      },
    );
  }
}
