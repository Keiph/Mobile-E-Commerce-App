import 'package:boogle_mobile/animations/slide_fade_animation.dart';
import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/screens/product_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/history_list.dart';
import 'package:boogle_mobile/providers/product_list.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //initialise _controller to TextEditingController class
  final _controller = TextEditingController();
  //initialise searchList as empty
  List<Product> searchList = [];

  @override
  void initState() {
    //whenever this route is active initialise searchList with the value of 'return myProductList'
    searchList = ProductList().getAllProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // calls ProductList provider
    ProductList allProductList = Provider.of<ProductList>(context);
    //cals HistoryList provider
    HistoryList historyList = Provider.of<HistoryList>(context);

    //Searching Functionality
    void searchProduct(String query) {
      //initialise each Product (Object) in getAllProductList() method to searchProduct
      final results = allProductList.getAllProductList().where((searchProduct) {
        final productName = searchProduct.productName.toLowerCase();
        final input = query.toLowerCase();
        // compares both lower cased productName and input to return productName
        // that is similar with the input
        return productName.contains(input);
      }).toList();
      //changes the UI screen with the new List from .toList()
      setState(() {
        // initialise searchList to result receiving a list of instance of Product
        searchList = results;
      });
    }

    //When _refresh method is called delay this function by 3 seconds
    Future<void> _refresh() {
      return Future.delayed(
        const Duration(seconds: 3),
      );
    }

    //returns size of the screen (width) and (height)
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
            vertical: size.height * 0.1,
            horizontal: size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideFadeAnimation(
                position: 1,
                child: TextField(
                  controller: _controller,
                  style: TextStyleConst.kBlackMediumSemi,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    contentPadding:
                        const EdgeInsets.fromLTRB(30.0, 20.0, 30, 20.0),
                    hintText: 'Search',
                    hintStyle: TextStyleConst.kBlackMediumSemi,
                  ),
                  //calls searchProduct method
                  onChanged: searchProduct,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SlideFadeAnimation(
                position: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Search:',
                      style: TextStyleConst.kMediumBold,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Flexible(
                      child: Text(
                        // takes value of TextField
                        _controller.text,
                        style: TextStyleConst.kSmallSemi,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SlideFadeAnimation(
                  position: 3,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyApp.themeNotifier.value == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),

                    //if List is empty, the screen displays Not found
                    //else display the gridview
                    child: searchList.isEmpty
                        ? Center(
                            child: Container(
                              child: const SizedBox(
                                width: double.infinity,
                                height: 300,
                              ),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'images/153-1533013_sorry-no-results-found.png',
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _refresh,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                              //display all items in the list
                              itemCount: searchList.length,
                              itemBuilder: (ctx, i) {
                                //initialise each instance of the Product in the list to searchProduct
                                Product searchProduct = searchList[i];
                                return GestureDetector(
                                  //Hero Widgets used for navigation from Screen A to B and vice versa,
                                  //it is used to animate the navigation, the Hero Widgets looks for similar widget tree
                                  //for Screen A and B and determine the animation. Which is why tag is required
                                  child: Hero(
                                    tag: searchProduct,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10.0,
                                              bottom: 10.0,
                                              right: 10.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    searchProduct.productName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyleConst
                                                        .kWhiteSmallBold,
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
                                                  initialRating: searchProduct
                                                      .productRating,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 1,
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
                                                const SizedBox(width: 5.0),
                                                Text(
                                                  searchProduct.productRating
                                                      .toStringAsFixed(1),
                                                  style: TextStyleConst
                                                      .kWhiteSmallBold,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '\$${searchProduct.productPrice.toStringAsFixed(2)}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyleConst
                                                        .kWhiteSmallBold,
                                                  ),
                                                ),
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
                                                              0.2,
                                                            ),
                                                            blurRadius: 1,
                                                            offset:
                                                                const Offset(
                                                              5,
                                                              5,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 0.5,
                                                        ),
                                                        color: searchProduct
                                                            .productColors,
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
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            searchProduct.productImg,
                                          ),
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
                                    //calls addToHistory method from HistoryList Provider class
                                    historyList.addToHistory(
                                      searchProduct.productName,
                                      searchProduct.productImg,
                                      searchProduct.productDetails,
                                      searchProduct.productColors,
                                      searchProduct.productCategory,
                                      searchProduct.productPrice,
                                      searchProduct.productSizes,
                                      searchProduct.productRating,
                                      searchProduct.productCount,
                                    );

                                    Navigator.of(context).pushNamed(
                                      // navigate to Product route and passes arguments of a Instance of Product
                                      ProductScreen.routeName,
                                      arguments: searchProduct,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
