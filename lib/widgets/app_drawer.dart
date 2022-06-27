import 'package:boogle_mobile/screens/add_product_screen.dart';
import 'package:boogle_mobile/screens/history_screen.dart';
import 'package:boogle_mobile/screens/random_shuffle_screen.dart';
import 'package:boogle_mobile/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import '../screens/login_screen.dart';
import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.blue.shade700,
                padding: EdgeInsets.only(top: size.height * 0.1, bottom: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 54,
                      backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/men/32.jpg",
                      ),
                    ),
                    Text(
                      "Keiph",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    Text(
                      "2100860@student.tp.edu.sg",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Product'),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.of(context).pushNamed(AddProductScreen.routeName);
                },
              ),
              Divider(
                height: 3,
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text('History'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(HistoryScreen.routeName);
                },
              ),
              Divider(
                height: 3,
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
              ),
              ListTile(
                leading: Icon(Icons.question_mark),
                title: Text('Random'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushNamed(RandomShuffleScreen.routeName);
                },
              ),
              Divider(
                height: 3,
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.boxOpen),
                title: Text('Orders'),
                onTap: () {
                  Navigator.of(context).pushNamed(OrderScreen.routeName);
                },
              ),
              Divider(
                height: 3,
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(SettingsScreen.routeName);
                },
              ),
              Divider(
                height: 3,
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
              ),
              Divider(
                height: 3,
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black
                    : Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
