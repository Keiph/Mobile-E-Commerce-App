import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/providers/liked_list.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:boogle_mobile/widgets/empty_liked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/models/product.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({Key? key}) : super(key: key);

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FirestoreService fsService = FirestoreService();
    return StreamBuilder<List<Product>>(
        stream: fsService.getUserLikedItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return snapshot.data!.isEmpty
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
                        // this function does event handling when user clicks on '+' and '-' to increase the amount of product they are going to buy
                        void _decrementValidator() {
                          // if productCount is less than 2 set productCount else set productCount -= 1
                          snapshot.data![i].productCount < 2
                              ? snapshot.data![i].productCount
                              : setState(() {
                            snapshot.data![i].productCount -= 1;
                                });
                        }

                        //List View of product card
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              ProductScreen.routeName,
                              arguments: snapshot.data![i],
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
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: [
                                          //Hero Widgets used for navigation from Screen A to B and vice versa,
                                          //it is used to animate the navigation, the Hero Widgets looks for similar widget tree
                                          //for Screen A and B and determine the animation. Which is why tag is required
                                          Hero(
                                            tag: snapshot.data![i].id,
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
                                                    snapshot.data![i].productImg,
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
                                                  initialRating: snapshot.data![i]
                                                      .productRating,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 18.0,
                                                  itemPadding: const EdgeInsets
                                                      .symmetric(
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
                                                  snapshot.data![i].productName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyleConst.kSmallBold,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 3.0),
                                                child: ClipOval(
                                                  child: Material(
                                                    color: MyApp.themeNotifier
                                                                .value ==
                                                            ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    child: InkWell(
                                                      splashColor: Colors.red[
                                                          300], // Splash color
                                                      onTap: () {
                                                        // calls Provider method to remove product from the list
                                                        fsService.removeFromLiked(snapshot.data![i].id);
                                                        // shows a toast msg upon removing of product from list
                                                        Fluttertoast.showToast(
                                                          msg: snapshot.data![i]
                                                                  .productName +
                                                              ' has been removed from liked',
                                                          toastLength:
                                                              Toast.LENGTH_LONG,
                                                          gravity:
                                                              ToastGravity.TOP,
                                                          backgroundColor:
                                                              Colors.black,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0,
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        width: 32,
                                                        height: 32,
                                                        child: Icon(
                                                          Icons.close,
                                                          color: MyApp.themeNotifier
                                                                      .value ==
                                                                  ThemeMode
                                                                      .light
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
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '\$${snapshot.data![i].productPrice.toStringAsFixed(2)}',
                                                )
                                              ],
                                            ),
                                          ),

                                          //Product Color
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
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
                                                                .withOpacity(
                                                                    0.3),
                                                            blurRadius: 1,
                                                            offset:
                                                                const Offset(
                                                                    3, 3),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        color: Color(snapshot.data![i]
                                                            .productColors),
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
                      itemCount: snapshot.data!.length,
                    ),
                  );
          }
        });
  }
}
