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
  bool themeChecker() {
    if (MyApp.themeNotifier.value == ThemeMode.light) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future openBrowserURL({
      required Uri url,
    }) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
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
                  vertical: size.height * 0.05, horizontal: size.width * 0.05),
              child: Column(
                children: [
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
                  SwitchListTile(
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
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.globe),
                  title: const Text(
                    'Our Website',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    const url = 'https://boogle.com.sg/';
                    openBrowserURL(url: Uri.parse(url));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
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
                ListTile(
                  title: const Text(
                    'Our Social Media',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
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
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
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
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text(
                    'More Info',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
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
