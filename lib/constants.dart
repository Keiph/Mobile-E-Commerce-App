
import 'package:boogle_mobile/main.dart';
import 'package:flutter/material.dart';


 Color kDarkOrLightTheme = MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black;
 Color kSecondaryDarkOrLightTheme = MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white;

 class ColorConst{
   static const Color kBluePrimaryBtn = Color(0xff314df8);
   static const Color kWhiteSecondaryBtn = Color(0xffe6f0fd);
}