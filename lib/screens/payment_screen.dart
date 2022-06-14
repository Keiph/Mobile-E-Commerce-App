import 'package:boogle_mobile/widgets/payment_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/product.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = '/payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: Container(
            margin: EdgeInsets.all(0.0),
            child: PaymentStepper()),
    );
  }
}
