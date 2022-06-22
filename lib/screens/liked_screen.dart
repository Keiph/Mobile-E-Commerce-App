import 'package:boogle_mobile/providers/liked_list.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/widgets/empty_cart.dart';
import 'package:boogle_mobile/widgets/empty_liked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/product.dart';
import '../providers/cart_list.dart';

class LikedScreen extends StatefulWidget {
  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {


  @override
  Widget build(BuildContext context) {

    LikedList allLikedProduct = Provider.of<LikedList>(context);
    CartList cartProduct = Provider.of<CartList>(context);
    Size size = MediaQuery.of(context).size;
    bool isEmpty = true;

    if (allLikedProduct.getMyLikedList().length > 0) {
      isEmpty = false;
    }


    return isEmpty
        ?EmptyLiked()
        :SafeArea(
      minimum: EdgeInsets.only(
        top: size.height * 0.1,
        left: size.width * 0.02,
        right: size.width * 0.02,
      ),
      child: ListView.builder(
        //preserve scroll position
        key: const PageStorageKey<String>('page'),
        itemBuilder: (BuildContext context, int i) {
          Product likedProduct = allLikedProduct.getMyLikedList()[i];

          void _decrementValidator() {
            likedProduct.productCount < 2
                ? likedProduct.productCount
                : setState(() {
              likedProduct.productCount -= 1;
            });
          }

          return Container(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Column(
                          children: [
                            Container(
                              child: SizedBox(
                                width: size.width * 0.4,
                                height: size.height * 0.205,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(likedProduct.productImg),
                                  fit: BoxFit.cover,

                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: likedProduct.productRating,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
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
                          children:[
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  likedProduct.productName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              ClipOval(
                                child: Material(
                                  color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
                                  child: InkWell(
                                    splashColor: Colors.red[300], // Splash color
                                    onTap: () {
                                      allLikedProduct.removeFromLiked(i);
                                      Fluttertoast.showToast(
                                          msg: likedProduct.productName + " has been removed from app",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 5,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    },
                                    child: SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: Icon(Icons.close,
                                        color: MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black,),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Text('\$${likedProduct.productPrice.toStringAsFixed(2)}',)
                                ],
                          ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
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
                                          color: likedProduct.productColors,
                                          border: Border.all(width: 0.5),
                                          shape: BoxShape.circle,

                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      child: Icon(Icons.remove, size: 12,),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white)),
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
                                      child: Text('${likedProduct.productCount}'),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      child: Icon(Icons.add, size: 12,),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white)),
                                    ),
                                    onTap: () =>
                                        setState(() => likedProduct.productCount += 1),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            PaymentScreen.routeName,
                                            arguments: likedProduct);
                                      },
                                      child: Icon(Icons.attach_money),
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color(0xff00AB66),
                                        side: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),

                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {cartProduct.addToCart(
                                        likedProduct.productName,
                                        likedProduct.productImg,
                                        likedProduct.productDetails,
                                        likedProduct.productColors,
                                        likedProduct.productCategory,
                                        likedProduct.productPrice,
                                        likedProduct.productSizes,
                                        likedProduct.productRating,
                                        likedProduct.productCount
                                    );
                                    Fluttertoast.showToast(
                                        msg: likedProduct.productName + " has been added to cart",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                      },
                                    child: Icon(Icons.add_shopping_cart_sharp),
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff5890FF),
                                      side: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                                    )),
                                ),
                              ],
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
        itemCount: allLikedProduct.getMyLikedList().length,
      ),
    );
  }
}
