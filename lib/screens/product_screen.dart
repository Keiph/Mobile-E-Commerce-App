import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/cart_list.dart';
import 'package:boogle_mobile/screens/payment_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'package:boogle_mobile/providers/liked_list.dart';
import 'package:boogle_mobile/providers/product_list.dart';

class ProductScreen extends StatefulWidget {
  static String routeName = '/product';

  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // initialise i = 0
  int i = 0;

  // initialise isLiked = false
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    //gets the size of the screen width & and height
    Size size = MediaQuery.of(context).size;

    //call to use LikedList Provider
    LikedList allLikedProduct = Provider.of<LikedList>(context);
    //call to use CartList Provider
    CartList cartProduct = Provider.of<CartList>(context);
    //call to use ProductList Provider
    ProductList productList = Provider.of<ProductList>(context);
    //uses arguments passed from navigated screen
    Product selectedProduct =
        ModalRoute.of(context)?.settings.arguments as Product;

    // this function does event handling when user clicks on '+' and '-' to increase the amount of product they are going to buy
    void _decrementValidator() {
      // if productCount is less than 2 set productCount else set productCount -= 1
      selectedProduct.productCount < 2
          ? selectedProduct.productCount
          : setState(() {
              selectedProduct.productCount -= 1;
            });
    }

    //This method calls upon an Alert Dialog to check if user wants to delete
    //the Product Object of the "selectedProduct"
    void deleteProduct(selectedProduct) {
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
                        setState(
                          () => productList.deleteProduct(selectedProduct),
                        );
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
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //TODO: Implement Update Functionality upon setting up firebase
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // calls deleteProduct method from ProductList Provider
                  deleteProduct(selectedProduct);
                },
              ),
            ],
          ),
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
                  tag: selectedProduct,
                  // Product Image
                  child: Container(
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.25,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(selectedProduct.productImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
                            allLikedProduct.addToLiked(
                              selectedProduct.productName,
                              selectedProduct.productImg,
                              selectedProduct.productDetails,
                              selectedProduct.productColors,
                              selectedProduct.productCategory,
                              selectedProduct.productPrice,
                              selectedProduct.productSizes,
                              selectedProduct.productRating,
                              selectedProduct.productCount,
                            );
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
                              color: selectedProduct.productColors,
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

                  //Add & Remove Product Count Buttons
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
                          child: Text('${selectedProduct.productCount}'),
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
                        onTap: () =>
                            setState(() => selectedProduct.productCount += 1),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            PaymentScreen.routeName,
                            arguments: selectedProduct,
                          );
                        },
                        child: const Text('Buy Now'),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff00AB66),
                          side: BorderSide(
                            color: MyApp.themeNotifier.value == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // hide any existing snackbar
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          //call addToCart method from CartList Provider
                          cartProduct.addToCart(
                            selectedProduct.productName,
                            selectedProduct.productImg,
                            selectedProduct.productDetails,
                            selectedProduct.productColors,
                            selectedProduct.productCategory,
                            selectedProduct.productPrice,
                            selectedProduct.productSizes,
                            selectedProduct.productRating,
                            selectedProduct.productCount,
                          );
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
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  cartProduct.removeFromCart(i);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
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
}
