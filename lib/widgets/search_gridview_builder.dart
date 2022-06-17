import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_list.dart';

class SearchGridViewBuilder extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    ProductList allProductList = Provider.of<ProductList>(context);
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),

        itemBuilder: (ctx, i){
          Product currentProduct = allProductList.getAllProductList()[i];
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [

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
          );
        },
      itemCount: allProductList.getAllProductList().length,
    );
  }
}
