import 'package:boogle_mobile/widgets/cart_payment_stepper.dart';
import 'package:flutter/material.dart';

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
        title: Text('Payment'),
      ),
      body: Container(
          margin: EdgeInsets.all(0.0),
          child: CartPaymentStepper()),
    );
  }
}
