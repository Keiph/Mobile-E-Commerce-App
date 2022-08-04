import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/models/users.dart';
import 'package:boogle_mobile/screens/add_product_screen.dart';
import 'package:boogle_mobile/screens/history_screen.dart';
import 'package:boogle_mobile/screens/random_shuffle_screen.dart';
import 'package:boogle_mobile/screens/settings_screen.dart';
import 'package:boogle_mobile/services/auth_service.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/screens/login_screen.dart';
import 'package:boogle_mobile/screens/order_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  logOut() {
    AuthService authService = AuthService();
    return authService.logOut().then((value) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pushNamed(LoginScreen.routeName);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text('Logout successfully!'),));
    }

    ).catchError((error) {
      FocusScope.of(context).unfocus();
      String message = error.toString();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text(message),));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    FirestoreService fsService = FirestoreService();
    AuthService authService = AuthService();
    return StreamBuilder<FirestoreUser>(
      stream: fsService.getAuthUserFromFirestore(),
      builder: (context, snapshotUsers) {
        if (snapshotUsers.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Drawer(
            child: ListView(
              children: [
                Column(
                  children: [

                    //Profile Container
                    Container(
                      width: double.infinity,
                      color: Colors.blue.shade700,
                      padding: EdgeInsets.only(
                          top: size.height * 0.1, bottom: 20),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 54,
                            backgroundImage: NetworkImage(
                              'https://randomuser.me/api/portraits/men/32.jpg',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    fit:BoxFit.scaleDown,
                                    child: Text(
                                    snapshotUsers.data!.userName,
                                    style: TextStyleConst.kWhiteLargeSemi,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    fit:BoxFit.scaleDown,
                                    child: Text(
                                      authService.getCurrentUser()!.email!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      maxLines:1,
                                    ),
                                  ),
                                ),
                              ],
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

                        Navigator.of(context).pushNamed(
                            AddProductScreen.routeName);
                      },
                    ),
                    Divider(
                      height: 3,
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    ), ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Log Out'),
                      onTap: () {
                        logOut();
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

/*
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
*/
                    //Route to Login

                  ],
                ),
              ],
            ),
          );
        }
      });
  }
}
