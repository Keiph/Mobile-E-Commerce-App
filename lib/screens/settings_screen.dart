import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
class SettingsScreen extends StatefulWidget {
  static String routeName ='/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}



class _SettingsScreenState extends State<SettingsScreen> {

  bool themeChecker(){
    if (MyApp.themeNotifier.value == ThemeMode.light)
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black,
        ),
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
        title: Text('Settings',
          style: TextStyle(
            color: MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black,
          ),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: size.height *0.05, horizontal: size.width * 0.05),
        child: Column(
          children: [
            Row(
              children: [
                Text('Notification'),
                Expanded(
                  child: Divider(
                    height: 3,
                    color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            SwitchListTile(
              title: Row(
                children: [
                  Icon(MyApp.themeNotifier.value == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.dark_mode),
                  SizedBox(width: 20.0,),
                  Text(MyApp.themeNotifier.value == ThemeMode.light
                      ?'Light Mode'
                      :'Dark Mode'),
                ],
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: themeChecker(),
              onChanged: (value){
                setState(() {
                  MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                });
                },
              ),
            ],
        ),
        ),
    );
  }
}
