
import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:boogle_mobile/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/liked_list.dart';
import '../providers/product_list.dart';

class PopularGridViewBuilder extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    ProductList popularProductList = Provider.of<ProductList>(context);


    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),

      itemBuilder: (ctx, i){
        Product currentProduct = popularProductList.getPopularProduct()[i];
        /*return GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(ProductScreen.routeName,arguments: currentProduct);
          },
          child: Stack(
            children: [
              Image.network(currentProduct.productImg),
              Text(currentProduct.productName),
              Text('${currentProduct.productPrice}'),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: (currentProduct.productColors).withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(3,3)
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: currentProduct.productColors,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),

            ],
          ),
        );*/
        return GestureDetector(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(currentProduct.productName,style: TextStyle(color: Colors.white),),

              ],
            ),

            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(currentProduct.productImg),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.25),
                    BlendMode.darken
                ),
              ),
              borderRadius: BorderRadius.circular(15),
            ),

          ),
          onTap: (){
            Navigator.of(context).pushNamed(ProductScreen.routeName,arguments: currentProduct);
          },
        );
      },
      itemCount: 6,
    );
  }
}
