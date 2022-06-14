import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/widgets/quantity_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProductScreen extends StatelessWidget {
  static String routeName = '/product';

  @override
  Widget build(BuildContext context) {
    Product selectedProduct = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProduct.productName),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.network('https://assets5.lottiefiles.com/packages/lf20_fvw9spld.json'),
                  AspectRatio
                    (
                    aspectRatio: 16/9,
                      child: Image.network(selectedProduct.productImg,),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedProduct.productName),
                        Text('\$${selectedProduct.productPrice}'),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedProduct.productSizeUnit + ":" + selectedProduct.productSizes),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                  color: (selectedProduct.productColors).withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(3,3)
                                ),
                                ],
                              ),
                            ),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: selectedProduct.productColors,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Rating: ' + ' ${selectedProduct.productRating}'),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Details:'),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(selectedProduct.productDetails),
                    ),
                    QuantityCounter()

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
