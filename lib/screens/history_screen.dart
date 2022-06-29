import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/history_list.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/screens/search_screen.dart';
import 'package:boogle_mobile/widgets/popular_gridview_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:boogle_mobile/main.dart';

class HistoryScreen extends StatefulWidget {
  ///This [HistoryScreen] mainly uses [HistoryList] provider with Create, Read and Delete functionality
  ///The delete icon opens a [AlertDialog] for users to confirm their actions, in this case we are checking if user confirm its delete action
  ///Adding of Product to [HistoryList] is automated through [GestureDetector] in [PopularGridViewBuilder], [SearchScreen] and other screen that contains the Product Card

  static String routeName = '/history';

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void clearHistory(historyList) {
    showDialog<void>(
      context: context,
      builder: (context) {
        //builds a AlertDialog on screen

        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          actionsPadding: const EdgeInsets.all(10.0),
          title: const Center(
            child: Text(
              'Delete History?',
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
                      setState(() => historyList.clearHistory());
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: ' all items has been removed from history',
                        toastLength: Toast
                            .LENGTH_LONG, // 5 second duration (LONG) on Android device
                        gravity: ToastGravity
                            .TOP, // shows Toast Message on top of the screen
                        timeInSecForIosWeb:
                            5, // 5 second duration on other device
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //calls Provider Class in HistoryList
    HistoryList historyList = Provider.of<HistoryList>(context);
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
          'History',
          style: TextStyle(
            color: MyApp.themeNotifier.value == ThemeMode.light
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {
              //call clearHistory method in Provider class
              clearHistory(historyList);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.05,
          horizontal: size.width * 0.02,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (ctx, i) {
            // iterate and initialise each item in getMyHistoryList method Provider
            Product historyProduct = historyList.getMyHistoryList()[i];
            return GestureDetector(
              //Hero Widgets used for navigation from Screen A to B and vice versa,
              //it is used to animate the navigation, the Hero Widgets looks for similar widget tree
              //for Screen A and B and determine the animation. Which is why tag is required
              child: Hero(
                tag: historyProduct,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          bottom: 10.0,
                          right: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                historyProduct.productName,
                                // Text after constraints of Expanded to be in (...) to avoid Overflow error
                                overflow: TextOverflow.ellipsis,
                                style: TextStyleConst.kWhiteMediumBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          bottom: 10.0,
                          right: 10.0,
                        ),
                        child: Row(
                          children: [
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: historyProduct.productRating,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 1,
                              itemSize: 18.0,
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
                              historyProduct.productRating.toStringAsFixed(1),
                              style: TextStyleConst.kWhiteSmallBold,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          bottom: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                '\$${historyProduct.productPrice.toStringAsFixed(2)}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyleConst.kWhiteMediumBold,
                              ),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0.5),
                                    color: historyProduct.productColors,
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(historyProduct.productImg),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2),
                        BlendMode.darken,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductScreen.routeName,
                  arguments: historyProduct,
                );
              },
            );
          },
          itemCount: historyList.getMyHistoryList().length,
        ),
      ),
    );
  }
}
