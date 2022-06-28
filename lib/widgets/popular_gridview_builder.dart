import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/history_list.dart';
import 'package:boogle_mobile/providers/product_list.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PopularGridViewBuilder extends StatelessWidget {
  const PopularGridViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductList popularProductList = Provider.of<ProductList>(context);
    HistoryList historyList = Provider.of<HistoryList>(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: popularProductList.getPopularProduct().length,
      itemBuilder: (ctx, i) {
        Product currentProduct = popularProductList.getPopularProduct()[i];
        return AnimationConfiguration.staggeredGrid(
          position: i * 3,
          duration: const Duration(seconds: 2),
          columnCount: 2,
          child: SlideAnimation(
            verticalOffset: 30.0,
            child: FadeInAnimation(
              child: GestureDetector(
                child: Hero(
                  tag: currentProduct,
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
                                  currentProduct.productName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
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
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            bottom: 10.0,
                            right: 10.0,
                          ),
                          child: Row(
                            children: [
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: currentProduct.productRating,
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
                                currentProduct.productRating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
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
                                  '\$${currentProduct.productPrice.toStringAsFixed(2)}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
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
                                      color: currentProduct.productColors,
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
                        image: NetworkImage(currentProduct.productImg),
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
                  historyList.addToHistory(
                    currentProduct.productName,
                    currentProduct.productImg,
                    currentProduct.productDetails,
                    currentProduct.productColors,
                    currentProduct.productCategory,
                    currentProduct.productPrice,
                    currentProduct.productSizes,
                    currentProduct.productRating,
                    currentProduct.productCount,
                  );

                  Navigator.of(context).pushNamed(
                    ProductScreen.routeName,
                    arguments: currentProduct,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
