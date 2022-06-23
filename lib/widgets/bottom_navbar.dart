import 'package:boogle_mobile/screens/cart_screen.dart';
import 'package:boogle_mobile/screens/home_screen.dart';
import 'package:boogle_mobile/screens/liked_screen.dart';
import 'package:boogle_mobile/widgets/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/search_screen.dart';

class BottomNav extends StatefulWidget {

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 3 ? _drawerKey.currentState!.openEndDrawer() : setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
        child: Icon(Icons.shopping_cart),
        onPressed: () { Navigator.of(context).pushNamed(CartScreen.routeName); },
        elevation: 4.0,
        splashColor: const Color(0xff5890FF),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child:
        selectedIndex == 0 ? HomeScreen():
        selectedIndex == 1 ? SearchScreen():
        LikedScreen(),
      ),
      key: _drawerKey,
      endDrawer: AppDrawer(),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            canvasColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,

        ),
        child: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: selectedIndex,
          selectedItemColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black,
          unselectedItemColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.grey.shade300: Colors.grey.shade700,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: 'Liked'),
            BottomNavigationBarItem(icon: Icon(Icons.menu),label: "Menu"),
          ],
        ),
      ),
    );
  }
}
