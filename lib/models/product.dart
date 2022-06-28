import 'package:flutter/material.dart';

class Product {
  /// [productName],[productImg],[productDetails],[productCategory],[productSizes],[productPrice],[productRating],[productColors],[productCount] cannot be null

  String productName, productImg, productDetails, productCategory, productSizes;
  double productPrice, productRating;
  Color productColors;
  int productCount;

  Product({
    required this.productName,
    required this.productImg,
    required this.productDetails,
    required this.productCategory,
    required this.productColors,
    required this.productPrice,
    required this.productSizes,
    required this.productRating,
    required this.productCount,
  });
}
