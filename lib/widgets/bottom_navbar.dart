import 'package:boogle_mobile/screens/cart_screen.dart';
import 'package:boogle_mobile/screens/home_screen.dart';
import 'package:boogle_mobile/screens/liked_screen.dart';
import 'package:boogle_mobile/widgets/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/screens/search_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onItemTapped(int index) {
    index == 3
        ? _drawerKey.currentState!.openEndDrawer()
        : setState(() {
            selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
            ? Colors.black
            : Colors.white,
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(context).pushNamed(CartScreen.routeName);
        },
        elevation: 4.0,
        splashColor: const Color(0xff5890FF),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => selectedIndex = index);
          },
          children: const [
            HomeScreen(),
            SearchScreen(),
            LikedScreen(),
          ],
        ),
      ),
      key: _drawerKey,
      endDrawer: const AppDrawer(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.black
              : Colors.white,
        ),
        child: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: selectedIndex,
          selectedItemColor: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.white
              : Colors.black,
          unselectedItemColor: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.grey.shade300
              : Colors.grey.shade700,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              label: 'Liked',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
