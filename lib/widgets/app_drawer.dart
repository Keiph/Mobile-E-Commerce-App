import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/screens/add_product_screen.dart';
import 'package:boogle_mobile/screens/history_screen.dart';
import 'package:boogle_mobile/screens/random_shuffle_screen.dart';
import 'package:boogle_mobile/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/screens/login_screen.dart';
import 'package:boogle_mobile/screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: ListView(
        children: [
          Column(
            children: [

              //Profile Container
              Container(
                width: double.infinity,
                color: Colors.blue.shade700,
                padding: EdgeInsets.only(top: size.height * 0.1, bottom: 20),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 54,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/32.jpg',
                      ),
                    ),
                    Text(
                      'Keiph',
                      style: TextStyleConst.kWhiteLargeSemi,
                    ),
                    Text(
                      '2100860@student.tp.edu.sg',
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

              //Route to AddProduct
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add Product'),
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

              //Route to History
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('History'),
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

              //Route to Random
              ListTile(
                leading: const Icon(Icons.question_mark),
                title: const Text('Random'),
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

              //Route to Order
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.boxOpen),
                title: const Text('Orders'),
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

              //Route to Settings
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
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

              //Route to Login
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
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
