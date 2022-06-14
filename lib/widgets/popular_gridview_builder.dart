import 'package:boogle_mobile/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_list.dart';

class PopularGridViewBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ProductList homeProductList = Provider.of<ProductList>(context);
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),

      itemBuilder: (ctx, i){
        Product currentProduct = homeProductList.getPopularProduct()[i];
        return Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(ProductScreen.routeName,arguments: currentProduct);
            },
            child: Column(
              children: [
                Text(currentProduct.productName,style: TextStyle(color: Colors.white),)

              ],
            ),
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

        );
      },
      itemCount: 6,
    );
  }
}
