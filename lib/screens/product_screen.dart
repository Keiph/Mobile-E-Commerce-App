import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/screens/edit_product_screen.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';
import 'package:boogle_mobile/services/auth_service.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'package:boogle_mobile/providers/liked_list.dart';
import 'package:boogle_mobile/providers/product_list.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductScreen extends StatefulWidget {
  static String routeName = '/product';

  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  FirestoreService fsService = FirestoreService();
  // initialise i = 0
  int i = 0;

  // initialise isLiked = false
  bool isLiked = false;

  final FlutterTts flutterTts = FlutterTts();

  speak(String textToSpeech) async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(textToSpeech);
  }
  @override
  Widget build(BuildContext context) {

    FirestoreService fsService = FirestoreService();
    AuthService authService = AuthService();
    //gets the size of the screen width & and height
    Size size = MediaQuery.of(context).size;

    //uses arguments passed from navigated screen
    Product selectedProduct =
        ModalRoute.of(context)?.settings.arguments as Product;




    //This method calls upon an Alert Dialog to check if user wants to delete
    //the Product Object of the "selectedProduct"
    void deleteProduct(String id) {
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            actionsPadding: const EdgeInsets.all(10.0),
            title: const Center(
              child: Text(
                'Delete Product?',
                style: TextStyleConst.kLargeBold,
              ),
            ),
            content: const Text(
              'Upon deleting, this is an '
              '\nirreversible action.',
              textAlign: TextAlign.center,
              style: TextStyleConst.kMediumSemi,
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    //Cancel Button
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyleConst.kBlackMediumSemi,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorConst.kWhiteSecondaryBtn,
                        elevation: 5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  //Delete Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        fsService.removeProduct(id);
                        fsService.removeFromCart(id);
                        fsService.removeFromLiked(id);

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg: '${selectedProduct.productName} '
                              'has been removed from app',
                          toastLength: Toast.LENGTH_LONG, // timer 5 sec
                          gravity: ToastGravity.TOP, // places at top of screen
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyleConst.kWhiteMediumSemi,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorConst.kBluePrimaryBtn,
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return StreamBuilder<List<Product>>(
      stream: fsService.getProducts(),
      builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting)
    return Center(child: CircularProgressIndicator());
    else {
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
            title: Text(
              selectedProduct.productName,
              style: TextStyle(
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            actions: [authService.getCurrentUser()!.email == selectedProduct.ownerEmail ?
              Row(
                children: [

                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context, EditProductScreen.routeName, arguments: selectedProduct);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // calls deleteProduct method from ProductList Provider
                      deleteProduct(selectedProduct.id);
                    },
                  ),
                ],
              ): Container()
            ],
          ),
          body: SingleChildScrollView(
            child: Column(

              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    //Lottie Animation only appear as the background when image is smaller than it
                    Lottie.network(
                      'https://assets5.lottiefiles.com/packages/lf20_fvw9spld.json',
                    ),

                    //This Hero connects to the hero from our previous route
                    Hero(
                      tag: selectedProduct.id,
                      // Product Image
                      child: Image.network(
                        selectedProduct.productImg,
                        width: size.width
                      ),
                    ),

                    Positioned(
                      bottom:30,
                      right:30,
                      child: QrImage(
                        data: selectedProduct.productImg,
                        size: 100,
                        backgroundColor: Colors.white,
                        
                      )

                    ),

                    //Liked Button
                    Positioned(
                      top: 30,
                      right: 30,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          //if isLiked is true, Icon turn red else Icon stays black
                          icon: isLiked
                              ? const Icon(
                                  CupertinoIcons.heart_fill,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.black,
                                ),
                          onPressed: () {
                            setState(() {
                              //switches between true/false
                              isLiked = !isLiked;

                              // if isLiked is true call addToLiked method from LikedList Provider
                              // else call removeFromLiked method from LikedList Provider
                              if (isLiked) {
                                fsService.addToLiked(selectedProduct.id, selectedProduct.ownerEmail, selectedProduct.productName, selectedProduct.productImg, selectedProduct.productDetails, selectedProduct.productCategory, selectedProduct.productColors, selectedProduct.productPrice, selectedProduct.productSizes, selectedProduct.productRating, selectedProduct.productCount);
                              } else {
                                fsService.removeFromLiked('selectedProduct.id');
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 50,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              //Product Name
                              selectedProduct.productName,
                              style: TextStyleConst.kMediumBold,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            //Product Price
                            '\$${selectedProduct.productPrice.toStringAsFixed(2)}',
                            style: TextStyleConst.kMediumBold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          // Product Size
                          Flexible(
                            child: Text(
                              'Size: ' + selectedProduct.productSizes,
                              style: TextStyleConst.kMediumSemi,
                            ),
                          ),

                          // Product Color
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
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(selectedProduct.productColors).withOpacity(1),
                                  border: Border.all(width: 0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //Review Rating
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
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '${selectedProduct.productRating}',
                              style: TextStyleConst.kMediumBold,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon:Icon(Icons.mic),
                            onPressed: () => speak(selectedProduct.productDetails),

                          )
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Details:',
                          style: TextStyleConst.kMediumSemi,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),


                      // Product Detail
                      Row(
                        children: [
                          Flexible(
                            child: ReadMoreText(
                              selectedProduct.productDetails,
                              trimLines: 3,
                              style: TextStyleConst.kSmallSemi,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...Read more',
                              trimExpandedText: ' Less',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // hide any existing snackbar
                                fsService.addToCart(selectedProduct.id, selectedProduct.ownerEmail, selectedProduct.productName, selectedProduct.productImg, selectedProduct.productDetails, selectedProduct.productCategory, selectedProduct.productColors, selectedProduct.productPrice, selectedProduct.productSizes, selectedProduct.productRating, selectedProduct.productCount);

                                //show a snackbar upon calling method
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 2),
                                    content: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            selectedProduct.productName +
                                                ' has been added to cart',
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                );
                              },
                              child: const Text('Add to Cart'),
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xff5890FF),
                                side: BorderSide(
                                  color: MyApp.themeNotifier.value == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }
}
