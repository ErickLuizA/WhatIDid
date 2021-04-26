import 'package:flutter/material.dart';
import 'package:whatidid/presentation/screens/calendar/calendar_screen.dart';
import 'package:whatidid/presentation/screens/categories/categories_screen.dart';
import 'package:whatidid/presentation/screens/home/home_screen.dart';
import 'package:whatidid/presentation/screens/user/user_screen.dart';
import 'package:whatidid/presentation/widgets/app_bar_widget.dart';
import 'package:whatidid/presentation/widgets/fab_widget.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.view_list_outlined),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.event),
      label: 'Calendar',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'User',
    ),
  ];

  final screens = [
    HomeScreen(),
    CategoriesScreen(),
    CalendarScreen(),
    UserScreen(),
  ];

  final screenNames = ['Daily', 'Categories', 'Calendar', 'User'];
  final categories = ['Daily', null, null, null];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: screenNames[currentIndex],
        category: categories[currentIndex],
        context: context,
        index: currentIndex,
      ),
      body: screens[currentIndex],
      floatingActionButton: currentIndex == 3 || currentIndex == 2
          ? null
          : FabWidget(categories[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColorLight,
        unselectedIconTheme: Theme.of(context).iconTheme,
        selectedIconTheme: Theme.of(context).primaryIconTheme,
        selectedItemColor: Theme.of(context).primaryColorDark,
        currentIndex: currentIndex,
        onTap: onTap,
        items: navItems,
      ),
    );
  }
}
