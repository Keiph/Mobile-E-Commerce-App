import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/product_list.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class RandomShuffleScreen extends StatelessWidget {
  static String routeName = '/random-shuffle';
  Random random =Random();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: (){

                    Navigator.of(context).pushNamed(ProductScreen.routeName, arguments:  ProductList().getAllProductList()[random.nextInt( ProductList().getAllProductList().length)]);
                  },
                  child: Text('Random')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
