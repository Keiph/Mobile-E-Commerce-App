import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';
import 'package:boogle_mobile/widgets/empty_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../widgets/purchase_completion.dart';
import 'cart_payment_screen.dart';
import 'home_screen.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    CartList allCartProduct = Provider.of<CartList>(context);
    Size size = MediaQuery.of(context).size;
    bool isEmpty = true;

    if (allCartProduct.getMyCartList().length > 0) {
      isEmpty = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Cart'),
            Text('Total ' + allCartProduct.getTotalItems().toString() + ' Items'),

          ],
        ),
      ),
      body: isEmpty
          ? EmptyCart()
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int i) {
                        Product cartProduct = allCartProduct.getMyCartList()[i];

                        void _decrementValidator() {
                          cartProduct.productCount < 2
                              ? cartProduct.productCount
                              : setState(() {
                                  cartProduct.productCount -= 1;
                                });
                        }

                        return Container(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Card(
                              elevation: 5.0,
                              shape: Border.all(width: 0.5),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            child: Image.network(
                                              cartProduct.productImg,
                                              width: size.width * 0.45,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                RatingBar.builder(
                                                  ignoreGestures: true,
                                                  initialRating:
                                                      cartProduct.productRating,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 18.0,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 1.0),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {},
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  cartProduct.productName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              ClipOval(
                                                child: Material(
                                                  color: Colors
                                                      .black, // Button color
                                                  child: InkWell(
                                                    splashColor: Colors.red[
                                                        300], // Splash color
                                                    onTap: () {
                                                      allCartProduct.removeFromCart(i);

                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Row(
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  cartProduct.productName + ' has been removed to cart',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          behavior: SnackBarBehavior.floating,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(24),
                                                          ),
                                                          action: SnackBarAction(
                                                            label: "UNDO",
                                                            onPressed: () {
                                                              allCartProduct.addToCart(cartProduct.productName, cartProduct.productImg, cartProduct.productDetails, cartProduct.productColors, cartProduct.productCategory, cartProduct.productPrice, cartProduct.productSizes, cartProduct.productRating, cartProduct.productCount);
                                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                            },

                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: SizedBox(
                                                      width: 32,
                                                      height: 32,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '\$${cartProduct.productPrice.toStringAsFixed(2)}',
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10.0),
                                            child: Row(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.black.withOpacity(0.3),
                                                              blurRadius: 1,
                                                              offset: Offset(3, 3)),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        color: cartProduct.productColors,
                                                        border: Border.all(
                                                            width: 0.5),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10.0),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  child: Container(
                                                    width: 24,
                                                    height: 24,
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 12,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        border: Border.all()),
                                                  ),
                                                  onTap: _decrementValidator,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: 32,
                                                  height: 24,
                                                  child: Center(
                                                    child: Text(
                                                        '${cartProduct.productCount}'),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    border: Border.all(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  child: Container(
                                                    width: 24,
                                                    height: 24,
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 12,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        border: Border.all()),
                                                  ),
                                                  onTap: () => setState(() =>
                                                      cartProduct
                                                          .productCount += 1),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: allCartProduct.getMyCartList().length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                            ), ),
                            Text('\$${allCartProduct.getTotalAmount().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    CartPaymentScreen.routeName,
                                    arguments: allCartProduct.getMyCartList());
                              },
                              child: Text('Buy Now'),
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xff00AB66),
                                side: BorderSide(),
                              )),
                            ),
                        ],),],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
