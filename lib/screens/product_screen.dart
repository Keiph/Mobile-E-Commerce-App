import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/liked_list.dart';

class ProductScreen extends StatefulWidget {
  static String routeName = '/product';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int i = 0;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    LikedList allLikedProduct = Provider.of<LikedList>(context);
    CartList cartProduct = Provider.of<CartList>(context);
    Product selectedProduct =
        ModalRoute.of(context)?.settings.arguments as Product;



    void _decrementValidator() {
      selectedProduct.productCount < 2
          ? selectedProduct.productCount
          : setState(() {
              selectedProduct.productCount -= 1;
            });
    }

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
                  Lottie.network(
                      'https://assets5.lottiefiles.com/packages/lf20_fvw9spld.json'),
                  Positioned(
                    width: 320,
                    child: Image.network(
                      selectedProduct.productImg,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                        icon: isLiked
                            ? Icon(CupertinoIcons.heart_fill)
                            : Icon(CupertinoIcons.heart),
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;

                            if (isLiked) {
                              allLikedProduct.addToLiked(
                                  selectedProduct.productName,
                                  selectedProduct.productImg,
                                  selectedProduct.productDetails,
                                  selectedProduct.productColors,
                                  selectedProduct.productCategory,
                                  selectedProduct.productPrice,
                                  selectedProduct.productSizes,
                                  selectedProduct.productSizeUnit,
                                  selectedProduct.productRating,
                                  selectedProduct.productCount);
                            } else {
                              allLikedProduct.removeFromLiked(i);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(selectedProduct.productName)),
                        Text('\$${selectedProduct.productPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedProduct.productSizeUnit +
                            ":" +
                            selectedProduct.productSizes),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: (selectedProduct.productColors)
                                          .withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: Offset(3, 3)),
                                ],
                              ),
                            ),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: selectedProduct.productColors,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: selectedProduct.productRating,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 1,
                            itemSize: 18.0,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            '${selectedProduct.productRating}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Details:'),
                    ),
                    Row(
                      
                      children: [Flexible(child: Text(selectedProduct.productDetails)),],
                    ),

                    Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 32,
                            height: 32,
                            child: Icon(Icons.remove),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all()),
                          ),
                          onTap: _decrementValidator,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 64,
                          height: 32,
                          child: Center(
                            child: Text('${selectedProduct.productCount}'),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          child: Container(
                            width: 32,
                            height: 32,
                            child: Icon(Icons.add),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all()),
                          ),
                          onTap: () =>
                              setState(() => selectedProduct.productCount += 1),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  PaymentScreen.routeName,
                                  arguments: selectedProduct);
                            },
                            child: Text('Buy Now'),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff00AB66),
                              side: BorderSide(),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              cartProduct.addToCart(
                                  selectedProduct.productName,
                                  selectedProduct.productImg,
                                  selectedProduct.productDetails,
                                  selectedProduct.productColors,
                                  selectedProduct.productCategory,
                                  selectedProduct.productPrice,
                                  selectedProduct.productSizes,
                                  selectedProduct.productSizeUnit,
                                  selectedProduct.productRating,
                                  selectedProduct.productCount
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar
                                    (content:
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            selectedProduct.productName + ' has been added to cart', overflow: TextOverflow.ellipsis,
                                          )
                                      ),
                                    ],
                                  ),
                                    action: SnackBarAction(
                                      label: "UNDO",
                                      onPressed: () {
                                        cartProduct.removeFromCart(i);
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      },

                                    ),
                                  ),
                              );
                            },
                            child: Text('Add to Cart'),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff5890FF),
                              side: BorderSide(),
                            )),
                      ],
                    )
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
