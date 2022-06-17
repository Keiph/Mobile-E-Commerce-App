import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Container(
        child: Text('Hellw'),
      ),
    );
  }
}
