import 'package:flutter/material.dart';

class Product {
  /// [productName],[productImg],[productDetails],[productCategory],[productSizes],[productPrice],[productRating],[productColors],[productCount] cannot be null

  String id,productName, productImg, productDetails, productCategory, productSizes, ownerEmail;
  double productPrice, productRating;
  int productCount,productColors;

  Product({
    required this.id,
    required this.ownerEmail,
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

  Product.fromMap(Map <String, dynamic> snapshot,String id) :
        id = id,
        ownerEmail = snapshot['ownerEmail'] ?? '',
        productName = snapshot['productName'] ??'',
        productImg = snapshot['productImg'] ??'',
        productDetails = snapshot['productDetails'] ??'',
        productCategory = snapshot['productCategory'] ??'',
        productColors = snapshot['productColors'] ??'',
        productPrice = snapshot['productPrice'] ??'',
        productSizes = snapshot['productSizes'] ??'',
        productRating = snapshot['productRating'] ??'',
        productCount = snapshot['productCount'] ??'';
}
