import 'package:boogle_mobile/widgets/cart_payment_stepper.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CartPaymentScreen extends StatefulWidget {
  static String routeName = '/cart-payment';

  @override
  State<CartPaymentScreen> createState() => _CartPaymentScreenState();
}

class _CartPaymentScreenState extends State<CartPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black,
        ),
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
        title: Text('Payment',style: TextStyle(
        color:MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black),),
      ),
      body: Container(
          margin: EdgeInsets.all(0.0),
          child: CartPaymentStepper()),
    );
  }
}
