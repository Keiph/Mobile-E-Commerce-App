import 'package:boogle_mobile/providers/product_list.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class RandomShuffleScreen extends StatelessWidget {
  static String routeName = '/random-shuffle';
  final Random random = Random();

  RandomShuffleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProductScreen.routeName,
                    arguments: ProductList().getAllProductList()[random
                        .nextInt(ProductList().getAllProductList().length)],);
              },
              child: const Text('Random'),
            ),
          ],
        ),
      ),
    );
  }
}
