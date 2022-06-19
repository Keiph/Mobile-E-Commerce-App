import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Oh No!'),
          Image.asset('images/pngfind.com-cart-png-2727925.png'),
          Text('You have not add any items into cart yet!')
        ],
      ),
    );
  }
}
