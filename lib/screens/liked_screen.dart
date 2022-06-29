import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/providers/liked_list.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/widgets/empty_liked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/models/product.dart';

///

class LikedScreen extends StatefulWidget {
  const LikedScreen({Key? key}) : super(key: key);

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  Widget build(BuildContext context) {
    //calls Provider Class in LikedList
    LikedList allLikedProduct = Provider.of<LikedList>(context);
    //calls Provider Class in CartList
    CartList cartProduct = Provider.of<CartList>(context);
    Size size = MediaQuery.of(context).size;

    //initialise isEmpty = true
    bool isEmpty = true;

    //if LikedList is not an empty List, initialise isEmpty = false;
    if (allLikedProduct.getMyLikedList().isNotEmpty) {
      isEmpty = false;
    }

    // if isEmpty == true, EmptyLiked Widget Class is called else continue running the build method in this class
    return isEmpty
        ? const EmptyLiked()
        : SafeArea(
            minimum: EdgeInsets.only(
              top: size.height * 0.1,
              left: size.width * 0.02,
              right: size.width * 0.02,
            ),
            child: ListView.builder(
              //preserve scroll position upon navigating back to this screen
              key: const PageStorageKey<String>('page'),
              itemBuilder: (BuildContext context, int i) {
                Product likedProduct = allLikedProduct.getMyLikedList()[i];

                // this function does event handling when user clicks on '+' and '-' to increase the amount of product they are going to buy
                void _decrementValidator() {
                  // if productCount is less than 2 set productCount else set productCount -= 1
                  likedProduct.productCount < 2
                      ? likedProduct.productCount
                      : setState(() {
                          likedProduct.productCount -= 1;
                        });
                }

                //List View of product card
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductScreen.routeName,
                      arguments: likedProduct,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Column(
                                children: [
                                  //Hero Widgets used for navigation from Screen A to B and vice versa,
                                  //it is used to animate the navigation, the Hero Widgets looks for similar widget tree
                                  //for Screen A and B and determine the animation. Which is why tag is required
                                  Hero(
                                    tag: likedProduct,
                                    child: Container(
                                      //Product Image
                                      child: SizedBox(
                                        width: size.width * 0.4,
                                        height: size.height * 0.205,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            likedProduct.productImg,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //rating star
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating:
                                          likedProduct.productRating,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 18.0,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 1.0,
                                          ),
                                          itemBuilder: (context, _) =>
                                              const Icon(
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

                            //Product Name + Remove Button
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          likedProduct.productName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyleConst.kSmallBold,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 3.0),
                                        child: ClipOval(
                                          child: Material(
                                            color: MyApp.themeNotifier.value ==
                                                    ThemeMode.light
                                                ? Colors.black
                                                : Colors.white,
                                            child: InkWell(
                                              splashColor:
                                                  Colors.red[300], // Splash color
                                              onTap: () {
                                                // calls Provider method to remove product from the list
                                                allLikedProduct
                                                    .removeFromLiked(i);
                                                // shows a toast msg upon removing of product from list
                                                Fluttertoast.showToast(
                                                  msg: likedProduct.productName +
                                                      ' has been removed from liked',
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.TOP,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              },
                                              child: SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: Icon(
                                                  Icons.close,
                                                  color:
                                                      MyApp.themeNotifier.value ==
                                                              ThemeMode.light
                                                          ? Colors.white
                                                          : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //Product Price
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '\$${likedProduct.productPrice.toStringAsFixed(2)}',
                                        )
                                      ],
                                    ),
                                  ),

                                  //Product Color
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
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
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    blurRadius: 1,
                                                    offset: const Offset(3, 3),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color:
                                                    likedProduct.productColors,
                                                border: Border.all(width: 0.5),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Add & Remove Product Counter
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            child: const Icon(
                                              Icons.remove,
                                              size: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color:
                                                    MyApp.themeNotifier.value ==
                                                            ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white,
                                              ),
                                            ),
                                          ),
                                          onTap: _decrementValidator,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          width: 32,
                                          height: 24,
                                          child: Center(
                                            child: Text(
                                              '${likedProduct.productCount}',
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                              color:
                                                  MyApp.themeNotifier.value ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            child: const Icon(
                                              Icons.add,
                                              size: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color:
                                                    MyApp.themeNotifier.value ==
                                                            ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white,
                                              ),
                                            ),
                                          ),
                                          onTap: () => setState(
                                            () =>
                                                likedProduct.productCount += 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Buy Now Button + Add to Cart Button
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              PaymentScreen.routeName,
                                              arguments: likedProduct,
                                            );
                                          },
                                          child: const Icon(Icons.attach_money),
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color(0xff00AB66),
                                            side: BorderSide(
                                              color:
                                                  MyApp.themeNotifier.value ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // add new Object with required attributes value to the list
                                            cartProduct.addToCart(
                                              likedProduct.productName,
                                              likedProduct.productImg,
                                              likedProduct.productDetails,
                                              likedProduct.productColors,
                                              likedProduct.productCategory,
                                              likedProduct.productPrice,
                                              likedProduct.productSizes,
                                              likedProduct.productRating,
                                              likedProduct.productCount,
                                            );
                                            // show a toast msg upon adding
                                            Fluttertoast.showToast(
                                              msg: likedProduct.productName +
                                                  ' has been added to cart',
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 5,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            );
                                          },
                                          child: const Icon(
                                            Icons.add_shopping_cart_sharp,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color(0xff5890FF),
                                            side: BorderSide(
                                              color:
                                                  MyApp.themeNotifier.value ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
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
              //display all items in the list
              itemCount: allLikedProduct.getMyLikedList().length,
            ),
          );
  }
}
