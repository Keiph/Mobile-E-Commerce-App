import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/screens/cart_payment_screen.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:boogle_mobile/widgets/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:boogle_mobile/main.dart';

class CartScreen extends StatefulWidget {
  ///This [CartScreen] mainly uses [CartList] provider with Create, Read and Delete functionality
  ///The [CartScreen] provides in-built functions like decrementing the count of the Product

  static String routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //get the size of my screen
    Size size = MediaQuery.of(context).size;
    FirestoreService fsService = FirestoreService();


    return StreamBuilder<List<Product>>(
      stream: fsService.getUserCartItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          int itemCount =0;
          snapshot.data!.forEach((doc){
            itemCount += doc.productCount;
          });

          double totalPrice =0;
          snapshot.data!.forEach((doc){
            totalPrice += doc.productPrice * doc.productCount;
          });


          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.white
                    : Colors.black,
              ),
              backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cart',
                    style: TextStyle(
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),

                  //displays the total number for all product in the CartList, by calling the CartList provider function get total items
                  Text(
                    'Total ' + '$itemCount' + ' Items',
                    style: TextStyle(
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // if isEmpty is true, EmptyCart Widget class gets called. Else SafeArea Widget is called
            body: snapshot.data!.isEmpty
              ? const EmptyCart()
            :SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int i) {


                        void _decrementValidator() {
                          // if productCount is less than 2 set productCount else set productCount -= 1
                          snapshot.data![i].productCount < 2
                              ? snapshot.data![i].productCount
                              : setState(() {
                            snapshot.data![i].productCount -= 1;
                          });
                        }

                        //List View product card
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Card(
                            elevation: 5.0,
                            shape: Border.all(width: 0.5),
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
                                        Container(
                                          child: SizedBox(
                                            // takes up 4/10 width of screen and 1.5/10 height of screen
                                            width: size.width * 0.4,
                                            height: size.height * 0.15,
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

                                        //Rating Star
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              RatingBar.builder(
                                                ignoreGestures: true,
                                                initialRating:
                                                snapshot.data![i].productRating,
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
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Name of Product placeholder
                                            Expanded(
                                              child: Text(
                                                snapshot.data![i].productName,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: TextStyleConst
                                                    .kMediumBold,
                                              ),
                                            ),

                                            //Remove Button
                                            ElevatedButton(
                                              onPressed: () {
                                                // hide any existing snackbar, so it does not overwrites
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();

                                                // calls removeFromCart method from CartList Provider
                                                fsService.removeFromCart(snapshot.data![i].id);

                                                // show snackbar content
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    duration: const Duration(
                                                      seconds: 1,
                                                    ),
                                                    content: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            snapshot.data![i]
                                                                .productName +
                                                                ' has been removed to cart',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                        24,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Icon(Icons.close),
                                              style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                padding:
                                                const EdgeInsets.all(2.0),
                                              ),
                                            ),
                                          ],
                                        ),

                                        //Product Price Placeholder
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10.0,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '\$${snapshot.data![i]
                                                    .productPrice
                                                    .toStringAsFixed(2)}',
                                              )
                                            ],
                                          ),
                                        ),


                                        //Product Color Placeholder
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10.0,
                                          ),
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
                                                            0.3,
                                                          ),
                                                          blurRadius: 1,
                                                          offset:
                                                          const Offset(
                                                            3,
                                                            3,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: Color(
                                                          snapshot.data![i]
                                                              .productColors),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        //Add & Minus Product Count Button
                                        Row(
                                          children: [
                                            GestureDetector(
                                              child: Container(
                                                width: 32,
                                                height: 32,
                                                child: const Icon(Icons.remove),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  border: Border.all(
                                                    color:
                                                    MyApp.themeNotifier.value == ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              onTap: _decrementValidator,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 64,
                                              height: 32,
                                              child: Center(
                                                child: Text('${snapshot.data![i].productCount}'),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5.0),
                                                border: Border.all(
                                                  color: MyApp.themeNotifier.value == ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                width: 32,
                                                height: 32,
                                                child: const Icon(Icons.add),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  border: Border.all(
                                                    color:
                                                    MyApp.themeNotifier.value == ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                fsService
                                                    .increaseCartProductCount(
                                                    snapshot.data![i].id,
                                                    snapshot.data![i]
                                                        .productCount);
                                              }
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
                        );
                      },

                      //GridView Builder to Build the Context according to the total amount of object in myCartList
                      itemCount: snapshot.data!.length,
                    ),
                  ),


                  //Cart Footer
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyleConst.kLargeBold,
                            ),

                            //display total amount of $$ for all items in CartList
                            Text(
                              '\$${totalPrice.toStringAsFixed(2)}',
                              style: TextStyleConst.kLargeBold,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    CartPaymentScreen.routeName,
                                  );
                                },
                                child: const Text('Buy Now'),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorConst.kBuyBtn,
                                  side: BorderSide(
                                    color: MyApp.themeNotifier.value ==
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
          );
        }
      });
  }
}
