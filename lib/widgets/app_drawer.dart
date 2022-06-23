import 'package:boogle_mobile/screens/add_product_screen.dart';
import 'package:boogle_mobile/screens/history_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

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
                padding: EdgeInsets.only(top: size.height *0.1, bottom: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 54,
                      backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/32.jpg",),
                    ),
                    Text("Keiph", style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w500, fontSize: 18),),
                    Text("2100860@student.tp.edu.sg", style: TextStyle(color: Colors.white, ),),
                  ],
                ),
              ),
              Divider(
                height: 3,
                color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
              ),

          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Product'),
            onTap: (){
              Navigator.pop(context);

              Navigator.of(context).pushNamed(AddProductScreen.routeName); },
          ),
          Divider(
            height: 3,
            color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text('History'),
            onTap: (){
              Navigator.pop(context);

              Navigator.of(context).pushNamed(HistoryScreen.routeName);},

          ),
          Divider(
            height: 3,
            color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: Text('Manage Profile'),
            onTap: (){ },
          ),
          Divider(
            height: 3,
            color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),

          ),
          Divider(
            height: 3,
            color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: (){ },
          ),
          Divider(
            height: 3,
            color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
          ),
              ListTile(
                leading: Icon(MyApp.themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                title: Text(MyApp.themeNotifier.value == ThemeMode.light? 'Dark Mode': 'Light Mode'),
                onTap: (){
                  MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                  },

              ),
              Divider(
                height: 3,
                  color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
              ),

        ],
      ),
    ],
    ),
    );
  }
}
