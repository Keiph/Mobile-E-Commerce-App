import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

    Future openBrowserURL({
      required Uri url,

    }) async{
      if (await canLaunchUrl(url)){
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }




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

        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height *0.05, horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('General'),
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
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.globe),
                    title: Text('Our Website',style: TextStyle(
                      fontWeight: FontWeight.w600,),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: (){
                      final url = 'https://boogle.com.sg/';
                      openBrowserURL( url: Uri.parse(url));
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Contact Us',style: TextStyle(
                      fontWeight: FontWeight.w600,),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {
                      final _phoneNumber = '+1234567890';
                      final _url = 'tel:$_phoneNumber';
                      if (await canLaunchUrlString(_url)){
                        await launchUrlString(_url);
                      }
                    },
                  ),


                  ListTile(
                    title: Text('Our Social Media',style: TextStyle(
                      fontWeight: FontWeight.w600,

                    ),),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  tileColor: const Color(0xff4267B2),
                                  leading:  FaIcon(FontAwesomeIcons.facebookSquare, color: Colors.white,),
                                  title: Text('Facebook', style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold,color: Colors.white),),
                                  onTap: () async {
                                    final url = 'https://www.facebook.com/';
                                    openBrowserURL( url: Uri.parse(url));
                                  },
                                ),
                                ListTile(
                                  tileColor: const Color(0xff0072b1),
                                  leading: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white,),
                                  title: Text('LinkedIn', style: TextStyle( fontSize: 18, fontWeight:FontWeight.bold,color: Colors.white),),
                                  onTap: () {
                                    final url = 'https://www.linkedin.com/in/keiph-yeow-753b6b217/';
                                    openBrowserURL( url: Uri.parse(url));
                                  },
                                ),
                                ListTile(
                                  tileColor: const Color(0xff00acee),
                                  leading: FaIcon(FontAwesomeIcons.twitterSquare, color: Colors.white,),
                                  title: Text('Twitter', style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold,color: Colors.white),),
                                  onTap: () {
                                    final url = 'https://twitter.com/home?lang=en';
                                    openBrowserURL( url: Uri.parse(url));
                                  },
                                ),
                                ListTile(
                                  tileColor: const Color(0xffE1306C),
                                  leading: FaIcon(FontAwesomeIcons.instagram, color: Colors.white,),
                                  title: Text('Instagram', style: TextStyle( fontSize: 18, fontWeight:FontWeight.bold,color: Colors.white),),
                                  onTap: () {
                                    final url ='https://www.instagram.com/?hl=en';
                                    openBrowserURL( url: Uri.parse(url));
                                  },
                                ),

                              ],
                            );
                          });

                    },
                  ),



                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('More Info',style: TextStyle(
                      fontWeight: FontWeight.w600,

                    ),),
                    onTap: (){ showAboutDialog(
                        context: context,
                        applicationName: 'Boogle',
                        applicationVersion: 'v1.0.2',
                        applicationIcon: Container(
                          child: SizedBox(
                            width: 75,
                            height: 75,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/Boogle-logo.png'),
                            ),
                          ),
                        ),
                        applicationLegalese: 'Boogle serves its customers with utmost care and concern, we make sure all UI displayed is easy to learn so that customers have a better user experience '
                    );
                    },
                  ),

                ],
              ),
            ],
          ),
        ),
        ),
    );

  }
}
