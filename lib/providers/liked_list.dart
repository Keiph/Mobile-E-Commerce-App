
import 'package:flutter/material.dart';

import '../models/product.dart';

class LikedList with ChangeNotifier{
  List<Product> myLikedList = [];

  List<Product> getMyLikedList(){
    return myLikedList;
  }

  void addToLiked(productName,productImg,productDetails,productColors,productCategory,productPrice,productSizes,productRating,productCount){
    myLikedList.insert(0, Product(productName: productName, productImg: productImg, productDetails: productDetails, productCategory: productCategory, productColors: productColors, productPrice: productPrice, productSizes: productSizes, productRating: productRating, productCount: productCount));
    notifyListeners();
  }

  void removeFromLiked(i){
    myLikedList.removeAt(i);
    notifyListeners();
  }
}