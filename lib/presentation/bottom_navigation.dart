import 'package:flutter/material.dart';
import 'package:whatidid/presentation/screens/calendar/calendar_screen.dart';
import 'package:whatidid/presentation/screens/categories/categories_screen.dart';
import 'package:whatidid/presentation/screens/home/home_screen.dart';
import 'package:whatidid/presentation/screens/user/user_screen.dart';

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
      icon: Icon(Icons.list),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: 'Calendar',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'User',
    ),
  ];

  final screens = {
    0: HomeScreen(),
    1: CategoriesScreen(),
    2: CalendarScreen(),
    3: UserScreen(),
  };

  void onTap(int index) {
    setState(() {
      currentScreenIndex = index;
    });
  }

  int currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: screens[currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColorLight,
        unselectedIconTheme: Theme.of(context).iconTheme,
        selectedIconTheme: Theme.of(context).primaryIconTheme,
        selectedItemColor: Theme.of(context).primaryColorDark,
        currentIndex: currentScreenIndex,
        onTap: onTap,
        items: navItems,
      ),
    );
  }
}
