import 'package:boogle_mobile/screens/home_screen.dart';
import 'package:boogle_mobile/widgets/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/search_screen.dart';

class BottomNav extends StatefulWidget {

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 4 ? _drawerKey.currentState!.openEndDrawer() : setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        selectedIndex == 0 ? HomeScreen():
        selectedIndex == 1 ? SearchScreen():
        selectedIndex == 2 ? Text('Cart'):
        Text('Liked'),
      ),
      key: _drawerKey,
      endDrawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: selectedIndex,
        backgroundColor: Colors.white60,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: 'Liked'),
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: "Menu"),
        ],
      ),
    );
  }
}
