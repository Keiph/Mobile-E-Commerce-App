import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/history_list.dart';
import 'package:boogle_mobile/providers/product_list.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PopularGridViewBuilder extends StatelessWidget {
  int activeCategory;
  String categoryName = '';
  PopularGridViewBuilder(this.activeCategory);


  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();
    if( activeCategory > 1 ){
      if (activeCategory == 2){
        categoryName = 'shoes';
      } else if (activeCategory == 3){
        categoryName = 'clothes';
      } else if (activeCategory == 4){
        categoryName = 'computer&games';
      } else if (activeCategory == 5){
        categoryName = 'grocery';
      } else if (activeCategory == 6){
        categoryName = 'petSupplies';
      } else if (activeCategory == 7){
        categoryName = 'misc';
      }
      return StreamBuilder<List<Product>>(
          stream: fsService.getProductsByCategory(categoryName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if(!snapshot.hasData) {
              return Center(child: Text ('No Data'));
            }
            else {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (ctx, i) {
                  return AnimationConfiguration.staggeredGrid(
                    position: i * 3,
                    duration: const Duration(seconds: 2),
                    columnCount: 2,
                    child: SlideAnimation(
                      verticalOffset: 30.0,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          child: Hero(
                            tag: snapshot.data![i].id,
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
                                            snapshot.data![i].productName,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyleConst.kWhiteSmallBold,
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
                                          initialRating:
                                          snapshot.data![i].productRating,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 1,
                                          itemSize: 18.0,
                                          itemPadding: const EdgeInsets.symmetric(
                                              horizontal: 1.0),
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          snapshot.data![i].productRating
                                              .toStringAsFixed(1),
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '\$${snapshot.data![i].productPrice.toStringAsFixed(2)}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyleConst.kWhiteSmallBold,
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
                                                        .withOpacity(0.2),
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
                                                border: Border.all(width: 0.5),
                                                color:
                                                Color(snapshot.data![i].productColors).withOpacity(1),
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
                                  image: NetworkImage(snapshot.data![i].productImg),
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
                          );*/

                            print(snapshot.data!);
                            Navigator.of(context).pushNamed(
                              ProductScreen.routeName,
                              arguments: snapshot.data![i],

                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          });
    }
    else{
    return StreamBuilder<List<Product>>(
        stream: fsService.getProductsByRating(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, i) {
                return AnimationConfiguration.staggeredGrid(
                  position: i * 3,
                  duration: const Duration(seconds: 2),
                  columnCount: 2,
                  child: SlideAnimation(
                    verticalOffset: 30.0,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        child: Hero(
                          tag: snapshot.data![i].id,
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
                                          snapshot.data![i].productName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyleConst.kWhiteSmallBold,
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
                                        initialRating:
                                        snapshot.data![i].productRating,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 1,
                                        itemSize: 18.0,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      const SizedBox(width: 5.0),
                                      Text(
                                        snapshot.data![i].productRating
                                            .toStringAsFixed(1),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '\$${snapshot.data![i].productPrice.toStringAsFixed(2)}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyleConst.kWhiteSmallBold,
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
                                                      .withOpacity(0.2),
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
                                              border: Border.all(width: 0.5),
                                              color:
                                                  Color(snapshot.data![i].productColors).withOpacity(1),
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
                                image: NetworkImage(snapshot.data![i].productImg),
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
                          );*/

                          print(snapshot.data!);
                          Navigator.of(context).pushNamed(
                            ProductScreen.routeName,
                            arguments: snapshot.data![i],

                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }}
}
