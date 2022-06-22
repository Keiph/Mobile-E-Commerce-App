import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/providers/history_list.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/liked_list.dart';
import '../providers/product_list.dart';

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
    Size size = MediaQuery.of(context).size;
    LikedList allLikedProduct = Provider.of<LikedList>(context);
    CartList cartProduct = Provider.of<CartList>(context);
    ProductList productList = Provider.of<ProductList>(context);

    Product selectedProduct = ModalRoute.of(context)?.settings.arguments as Product;



    void _decrementValidator() {
      selectedProduct.productCount < 2
          ? selectedProduct.productCount
          : setState(() {
              selectedProduct.productCount -= 1;
            });
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black,
        ),
        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
        title: Text(selectedProduct.productName,
          style: TextStyle(
            color:MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black),
        ),
        actions:[
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed:() {

                },
              ),
              IconButton(
              icon: Icon(Icons.delete),
              onPressed:() {

                productList.deleteProduct(selectedProduct);

                Fluttertoast.showToast(
                    msg: selectedProduct.productName + " has been removed from app",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

                Navigator.pop(context);
              },
            ),
            ],
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                children: [
                  //Lottie Animation only appear as the background when image is smaller than it
                  Lottie.network('https://assets5.lottiefiles.com/packages/lf20_fvw9spld.json'),
                  Container(
                    child: SizedBox(
                      width: size.width *0.8,
                      height: size.height *0.25,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(selectedProduct.productImg),
                        fit: BoxFit.cover,

                      ),
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
                            ? Icon(CupertinoIcons.heart_fill, color: Colors.red,)
                            : Icon(CupertinoIcons.heart, color: Colors.black,),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(selectedProduct.productName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text('\$${selectedProduct.productPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text( 'Size: ' + selectedProduct.productSizes,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 1,
                                      offset: Offset(5, 5)),
                                ],
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 20,
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
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 1,
                            itemSize: 32.0,
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
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Details:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Flexible(
                            child: Text(selectedProduct.productDetails,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),

                    Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 32,
                            height: 32,
                            child: Icon(Icons.remove),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white)
                            ),
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
                            border: Border.all(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
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
                                border: Border.all(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white)),
                          ),
                          onTap: () =>
                              setState(() => selectedProduct.productCount += 1),
                        ),
                      ],
                    ),

                    SizedBox(height: 20,),

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

                                  selectedProduct.productRating,
                                  selectedProduct.productCount
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 3),
                                  content: Row(
                                  children: [
                                    Flexible(
                                        child: Text(
                                          selectedProduct.productName + ' has been added to cart',
                                        ),
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
