import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/providers/liked_list.dart';

import 'package:boogle_mobile/providers/product_list.dart';
import 'package:boogle_mobile/screens/cart_payment_screen.dart';
import 'package:boogle_mobile/screens/cart_screen.dart';
import 'package:boogle_mobile/screens/forgot_password_screen.dart';

import 'package:boogle_mobile/screens/login_screen.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/screens/search_screen.dart';

import 'package:boogle_mobile/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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

      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
        routes: {
          LoginScreen.routeName: (_) { return LoginScreen(); },
          ForgotPasswordScreen.routeName: (_) { return ForgotPasswordScreen(); },
          ProductScreen.routeName: (_) {return ProductScreen();},
          PaymentScreen.routeName: (_) {return PaymentScreen();},
          CartPaymentScreen.routeName: (_) {return CartPaymentScreen();},
          CartScreen.routeName: (_) {return CartScreen();}


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
