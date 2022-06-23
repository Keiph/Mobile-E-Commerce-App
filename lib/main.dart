import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/providers/history_list.dart';
import 'package:boogle_mobile/providers/liked_list.dart';


import 'package:boogle_mobile/providers/product_list.dart';
import 'package:boogle_mobile/screens/add_product_screen.dart';
import 'package:boogle_mobile/screens/cart_payment_screen.dart';
import 'package:boogle_mobile/screens/cart_screen.dart';
import 'package:boogle_mobile/screens/forgot_password_screen.dart';
import 'package:boogle_mobile/screens/history_screen.dart';
import 'package:boogle_mobile/screens/home_screen.dart';

import 'package:boogle_mobile/screens/login_screen.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/screens/search_screen.dart';

import 'package:boogle_mobile/widgets/bottom_navbar.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductList>(
          create: (ctx) => ProductList(),
        ),
        ChangeNotifierProvider<LikedList>(
          create: (ctx) => LikedList(),
        ),
        ChangeNotifierProvider<CartList>(
          create: (ctx) => CartList(),
        ),
        ChangeNotifierProvider<HistoryList>(
          create: (ctx) => HistoryList(),
        ),

      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __){
          return MaterialApp(
            supportedLocales: [
              Locale('en','US'),
              Locale('en','UK'),
            ],
        localizationsDelegates: [
          CountryLocalizations.delegate
        ],
        debugShowCheckedModeBanner: false,

            theme: ThemeData(
              fontFamily: 'Montserrat',
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData.dark().copyWith(
              textTheme: ThemeData.dark().textTheme.apply(
                fontFamily: 'Montserrat',
              ),
              primaryTextTheme: ThemeData.dark().textTheme.apply(
                fontFamily: 'Montserrat',
              ),

            ),

            themeMode: currentMode,
        home: MainScreen(),
        routes: {
          LoginScreen.routeName: (_) { return LoginScreen(); },
          ForgotPasswordScreen.routeName: (_) { return ForgotPasswordScreen(); },
          ProductScreen.routeName: (_) {return ProductScreen();},
          PaymentScreen.routeName: (_) {return PaymentScreen();},
          CartPaymentScreen.routeName: (_) {return CartPaymentScreen();},
          CartScreen.routeName: (_) {return CartScreen();},
          AddProductScreen.routeName: (_) {return AddProductScreen();},
          HistoryScreen.routeName: (_) {return HistoryScreen();},


        },
      );
  },
    ),

    );
  }
}

class MainScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(),

      bottomNavigationBar: BottomNav()
    );

  }
}
