import 'package:boogle_mobile/screens/history_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("Keiph", style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w500, fontSize: 24),),
              accountEmail: Text("Keiph@gmail.com", style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network("https://randomuser.me/api/portraits/men/32.jpg", width: 90, height: 90, fit: BoxFit.cover,),
                ),
              ),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text('History'),
            onTap: (){ Navigator.of(context).pushNamed(HistoryScreen.routeName);},

          ),
          Divider(
            height: 3,
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: Text('Manage Profile'),
          ),
          Divider(
            height: 3,
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          Divider(
            height: 3,
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
          ),
          Divider(
            height: 3,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
