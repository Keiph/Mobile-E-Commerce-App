import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/product.dart';
import '../providers/history_list.dart';
import '../providers/liked_list.dart';
import '../providers/product_list.dart';

class PopularGridViewBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProductList popularProductList = Provider.of<ProductList>(context);
    HistoryList historyList= Provider.of<HistoryList>(context);

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemBuilder: (ctx, i) {
        Product currentProduct = popularProductList.getPopularProduct()[i];
        return GestureDetector(
          child: Hero(
            tag: currentProduct,
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
                            currentProduct.productName,
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
                          initialRating: currentProduct.productRating,
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
                        Text('${currentProduct.productRating}',
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
                          child:Text(
                          '\$${currentProduct.productPrice.toStringAsFixed(2)}',
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
                                      offset: Offset(3, 3)),
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
                  colorFilter: MyApp.themeNotifier.value == ThemeMode.light
                      ?ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
                      :ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken)
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onTap: () {
            historyList.addToHistory(currentProduct.productName, currentProduct.productImg, currentProduct.productDetails, currentProduct.productColors, currentProduct.productCategory, currentProduct.productPrice, currentProduct.productSizes, currentProduct.productRating, currentProduct.productCount);

            Navigator.of(context).pushNamed(ProductScreen.routeName, arguments: currentProduct);
          },
        );
      },
      itemCount: popularProductList.getPopularProduct().length ,
    );
  }
}
