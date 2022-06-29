import 'package:boogle_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:boogle_mobile/main.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //method to check if the ThemeMode of the app is light
  //if true return false
  //else return false
  bool themeChecker() {
    if (MyApp.themeNotifier.value == ThemeMode.light) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //returns the value of the screen sizes
    Size size = MediaQuery.of(context).size;

    // the Future class allows the app to do stuff asynchronously potentially
    // multi-threading, a Future is completed in two ways either a value or an
    // error message
    Future openBrowserURL({
      required Uri url,
    }) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
      throw 'Could not launch $url';
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.white
              : Colors.black,
        ),
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
            ? Colors.black
            : Colors.white,
        title: Text(
          'Settings',
          style: TextStyle(
            color: MyApp.themeNotifier.value == ThemeMode.light
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.05,
                horizontal: size.width * 0.05,
              ),
              child: Column(
                children: [
                  //Header
                  Row(
                    children: [
                      const Text('General'),
                      Expanded(
                        child: Divider(
                          height: 3,
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Switch button for light/dark theme
                  SwitchListTile.adaptive(
                    title: Row(
                      children: [
                        Icon(
                          MyApp.themeNotifier.value == ThemeMode.light
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          MyApp.themeNotifier.value == ThemeMode.light
                              ? 'Light Mode'
                              : 'Dark Mode',
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    // calls themeChecker method that returns true/false
                    // if true button is active else inactive
                    value: themeChecker(),
                    onChanged: (value) {
                      setState(() {
                        MyApp.themeNotifier.value =
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
                      });
                    },
                  ),
                ],
              ),
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                // Our Website
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.globe),
                  title: const Text(
                    'Our Website',
                    style: TextStyleConst.kMediumSemi,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    const url = 'https://boogle.com.sg/';
                    openBrowserURL(url: Uri.parse(url));
                  },
                ),

                //Contact Us
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text(
                    'Contact Us',
                    style: TextStyleConst.kMediumSemi,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    const _phoneNumber = '+1234567890';
                    const _url = 'tel:$_phoneNumber';
                    if (await canLaunchUrlString(_url)) {
                      await launchUrlString(_url);
                    }
                  },
                ),

                //Our Social Media
                ListTile(
                  title: const Text(
                    'Our Social Media',
                    style: TextStyleConst.kMediumSemi,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    //Opens a Bottom Sheet
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              tileColor: const Color(0xff4267B2),
                              leading: const FaIcon(
                                FontAwesomeIcons.facebookSquare,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Facebook',
                                style: TextStyleConst.kWhiteMediumSemi,
                              ),
                              onTap: () async {
                                const url = 'https://www.facebook.com/';
                                openBrowserURL(url: Uri.parse(url));
                              },
                            ),
                            ListTile(
                              tileColor: const Color(0xff0072b1),
                              leading: const FaIcon(
                                FontAwesomeIcons.linkedin,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'LinkedIn',
                                style: TextStyleConst.kWhiteMediumSemi,
                              ),
                              onTap: () {
                                const url =
                                    'https://www.linkedin.com/in/keiph-yeow-753b6b217/';
                                openBrowserURL(url: Uri.parse(url));
                              },
                            ),
                            ListTile(
                              tileColor: const Color(0xff00acee),
                              leading: const FaIcon(
                                FontAwesomeIcons.twitterSquare,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Twitter',
                                style: TextStyleConst.kWhiteMediumSemi,
                              ),
                              onTap: () {
                                const url = 'https://twitter.com/home?lang=en';
                                openBrowserURL(url: Uri.parse(url));
                              },
                            ),
                            ListTile(
                              tileColor: const Color(0xffE1306C),
                              leading: const FaIcon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Instagram',
                                style: TextStyleConst.kWhiteMediumSemi,
                              ),
                              onTap: () {
                                const url = 'https://www.instagram.com/?hl=en';
                                openBrowserURL(url: Uri.parse(url));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                //More Info
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text(
                    'More Info',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    //Opens Simple Dialog
                    showAboutDialog(
                      context: context,
                      applicationName: 'Boogle',
                      applicationVersion: 'v1.0.2',
                      applicationIcon: Container(
                        child: const SizedBox(
                          width: 75,
                          height: 75,
                        ),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/Boogle-logo.png'),
                          ),
                        ),
                      ),
                      applicationLegalese:
                          'Boogle serves its customers with utmost care and concern, we make sure all UI displayed is easy to learn so that customers have a better user experience ',
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
