
import 'package:boogle_mobile/main.dart';
import 'package:flutter/material.dart';


 Color kDarkOrLightTheme = MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black;
 Color kSecondaryDarkOrLightTheme = MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white;

 class ColorConst{
   static const Color kBluePrimaryBtn = Color(0xff314df8);
   static const Color kWhiteSecondaryBtn = Color(0xffe6f0fd);
   static const Color kBuyBtn = Color(0xff00AB66);
   static const Color kCartBtn =Color(0xff5890FF);
   static const Color kDefaultBlack = Color(0xff000000);
   static const Color kDefaultWhite = Color(0xffFFFFFF);
}

class TextStyleConst{
   static const kLargeBold =  TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
   static const kMediumBold =  TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
   static const kSmallBold =  TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

   static const kBlackLargeBold =  TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
   static const kBlackMediumBold =  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
   static const kBlackSmallBold =  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);

   static const kWhiteLargeBold =  TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
   static const kWhiteMediumBold =  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
   static const kWhiteSmallBold =  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);


   static const kLargeSemi =  TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
   static const kMediumSemi =  TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
   static const kSmallSemi =  TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

   static const kBlackLargeSemi =  TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black);
   static const kBlackMediumSemi =  TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black);
   static const kBlackSmallSemi =  TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);

   static const kWhiteLargeSemi =  TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white);
   static const kWhiteMediumSemi =  TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);
   static const kWhiteSmallSemi =  TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white);

}
const kErrorBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.red),);

const kDefaultAlertBorder = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0)));