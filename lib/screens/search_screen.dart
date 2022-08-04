import 'package:boogle_mobile/animations/slide_fade_animation.dart';
import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/services/firestore_service.dart';

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
  FirestoreService fsService = FirestoreService();
  //initialise _controller to TextEditingController class
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    //Searching Functionality

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
                    child: StreamBuilder<List<Product>>(
                      stream: fsService.getProducts(),
                      builder: (context,allSnapshot){
                      return StreamBuilder<List<Product>>(
                          stream: fsService.getProductsByText(_controller.text),
                          builder: (context, snapshot) {
                            if (snapshot.hasError || allSnapshot.hasError){
                              return Center(child: Text('Oh No Something Went Wrong on our side!'));
                            }
                            else if (snapshot.connectionState == ConnectionState.waiting || allSnapshot.connectionState == ConnectionState.waiting)
                              return Center(child: CircularProgressIndicator());
                            else if (_controller.text.isEmpty){
                              return GridView.builder(
                                gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                                //display all items in the list
                                itemCount: allSnapshot.data!.length,
                                itemBuilder: (ctx, i) {
                                  return GestureDetector(
                                    child: Hero(
                                      tag: allSnapshot.data![i].id,
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
                                                      allSnapshot
                                                          .data![i].productName,
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
                                                    initialRating: allSnapshot
                                                        .data![i].productRating,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 1,
                                                    itemSize: 18.0,
                                                    itemPadding:
                                                    const EdgeInsets
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
                                                    allSnapshot
                                                        .data![i].productRating
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
                                                      '\$${allSnapshot.data![i].productPrice.toStringAsFixed(2)}',
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
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                          BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
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
                                                        decoration:
                                                        BoxDecoration(
                                                          border: Border.all(
                                                            width: 0.5,
                                                          ),
                                                          color: Color(allSnapshot
                                                              .data![i]
                                                              .productColors),
                                                          shape:
                                                          BoxShape.circle,
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
                                              allSnapshot.data![i].productImg,
                                            ),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.2),
                                              BlendMode.darken,
                                            ),
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      //calls addToHistory method from HistoryList Provider class
                                      /*historyList.addToHistory(
                                          snapshot.data![i].productName,
                                          snapshot.data![i].productImg,
                                          snapshot.data![i].productDetails,
                                          snapshot.data![i].productColors,
                                          snapshot.data![i].productCategory,
                                          snapshot.data![i].productPrice,
                                          snapshot.data![i].productSizes,
                                          snapshot.data![i].productRating,
                                          snapshot.data![i].productCount,
                                        );
*/
                                      Navigator.of(context).pushNamed(
                                        // navigate to Product route and passes arguments of a Instance of Product
                                        ProductScreen.routeName,
                                        arguments: allSnapshot.data![i],
                                      );
                                    },
                                  );
                                },
                              );
                            }
                            else {
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                                //display all items in the list
                                itemCount: snapshot.data!.length,
                                itemBuilder: (ctx, i) {
                                    return GestureDetector(
                                      child: Hero(
                                        tag: snapshot.data![i].id,
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
                                                        snapshot
                                                            .data![i].productName,
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
                                                      initialRating: snapshot
                                                          .data![i].productRating,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 1,
                                                      itemSize: 18.0,
                                                      itemPadding:
                                                      const EdgeInsets
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
                                                      snapshot
                                                          .data![i].productRating
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
                                                        '\$${snapshot.data![i].productPrice.toStringAsFixed(2)}',
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
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                            BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
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
                                                          decoration:
                                                          BoxDecoration(
                                                            border: Border.all(
                                                              width: 0.5,
                                                            ),
                                                            color: Color(snapshot
                                                                .data![i]
                                                                .productColors),
                                                            shape:
                                                            BoxShape.circle,
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
                                                snapshot.data![i].productImg,
                                              ),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.2),
                                                BlendMode.darken,
                                              ),
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        //calls addToHistory method from HistoryList Provider class
                                        /*historyList.addToHistory(
                                          snapshot.data![i].productName,
                                          snapshot.data![i].productImg,
                                          snapshot.data![i].productDetails,
                                          snapshot.data![i].productColors,
                                          snapshot.data![i].productCategory,
                                          snapshot.data![i].productPrice,
                                          snapshot.data![i].productSizes,
                                          snapshot.data![i].productRating,
                                          snapshot.data![i].productCount,
                                        );
*/
                                        Navigator.of(context).pushNamed(
                                          // navigate to Product route and passes arguments of a Instance of Product
                                          ProductScreen.routeName,
                                          arguments: snapshot.data![i],
                                        );
                                      },
                                    );
                                  },
                              );
                            }
                          },);}
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
