import 'package:boogle_mobile/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:boogle_mobile/main.dart';

class PurchaseCompletion extends StatelessWidget {
  const PurchaseCompletion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Lottie.asset('lotties/74644-add-to-basket.json',
              fit: BoxFit.cover, repeat: false,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 150),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Shop More'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(MainScreen.routeName);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Check Order'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(OrderScreen.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
