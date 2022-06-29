import 'package:boogle_mobile/widgets/payment_stepper.dart';
import 'package:flutter/material.dart';

import 'package:boogle_mobile/main.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = '/payment';

  /// [PaymentScreen] uses a separate Widget to build the content of the [Stepper]

  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
            'Payment',
            style: TextStyle(
              color: MyApp.themeNotifier.value == ThemeMode.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(0.0),
          child: const PaymentStepper(),
        ),
      ),
    );
  }
}
