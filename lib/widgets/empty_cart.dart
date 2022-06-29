import 'package:boogle_mobile/constants.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Oh No!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Image.asset('images/pngfind.com-cart-png-2727925.png'),
        ),
        const Expanded(
          flex: 2,
          child: Text(
            'You have not add \nany items into cart yet!',
            textAlign: TextAlign.center,
            style: TextStyleConst.kMediumSemi,
          ),
        ),
      ],
    );
  }
}
