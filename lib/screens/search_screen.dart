import 'package:boogle_mobile/animations/slide_fade_animation.dart';
import 'package:boogle_mobile/screens/product_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/product.dart';
import '../providers/history_list.dart';
import '../providers/product_list.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  final _controller = TextEditingController();
  List<Product> searchList = ProductList().getAllProductList();
  //this one line of code cost me 8 hours to debug :_)



  @override
  Widget build(BuildContext context) {
    ProductList allProductList = Provider.of<ProductList>(context);
    HistoryList historyList= Provider.of<HistoryList>(context);


    void searchBook(String query){
        final results = allProductList.getAllProductList().where((searchProduct){
          final productName = searchProduct.productName.toLowerCase();
          final input = query.toLowerCase();
          return productName.contains(input);
        }).toList();
        setState(() {
        searchList = results;
      });
    }
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          minimum: EdgeInsets.symmetric(vertical: size.height *0.1, horizontal: size.width *0.05),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideFadeAnimation(
                  position: 1,
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      color:Colors.black
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.black,),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30, 20.0),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    onChanged: searchBook,

                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SlideFadeAnimation(
                  position: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Search:',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      Flexible(
                        child: Text(_controller.text,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                Expanded(
                  child: SlideFadeAnimation(
                    position: 3,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,),
                        borderRadius: BorderRadius.circular(18.0),

                      ),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                        itemCount: searchList.length,
                        itemBuilder: (ctx, i){
                          Product searchProduct = searchList[i];
                          return GestureDetector(
                            child: Hero(
                              tag: searchProduct,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, bottom:10.0, right: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              searchProduct.productName,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, bottom:10.0, right: 10.0),
                                      child: Row(
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            initialRating: searchProduct.productRating,
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
                                          const SizedBox(width: 5.0),
                                          Text('${searchProduct.productRating}',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, right:10.0, bottom: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '\$${searchProduct.productPrice.toStringAsFixed(2)}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
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
                                                        color: Colors.black.withOpacity(0.2),
                                                        blurRadius: 1,
                                                        offset: Offset(5, 5)),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 0.5),
                                                  color: searchProduct.productColors,
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
                                      image: NetworkImage(searchProduct.productImg),
                                      fit: BoxFit.cover,
                                      colorFilter: MyApp.themeNotifier.value == ThemeMode.light
                                          ?ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
                                          :ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken)
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            onTap: (){
                              historyList.addToHistory(searchProduct.productName, searchProduct.productImg, searchProduct.productDetails, searchProduct.productColors, searchProduct.productCategory, searchProduct.productPrice, searchProduct.productSizes, searchProduct.productRating, searchProduct.productCount);

                              Navigator.of(context).pushNamed(ProductScreen.routeName, arguments: searchProduct);

                            },
                          );
                        },

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }


}


