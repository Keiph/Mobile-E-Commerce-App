import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';

class PurchaseCompletion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Lottie.asset('lotties/74644-add-to-basket.json', fit: BoxFit.cover, repeat: false),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 150),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Shop More'),
                      onPressed: (){Navigator.of(context).pushReplacementNamed(MainScreen.routeName);}
                    ),
                  ),
                  const SizedBox(width: 12,),

                  Expanded(
                    child: ElevatedButton(
                      child: Text('Check Order'),
                      onPressed: (){}
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
