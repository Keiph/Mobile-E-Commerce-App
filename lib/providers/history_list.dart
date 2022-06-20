

import 'package:boogle_mobile/models/product.dart';
import 'package:flutter/material.dart';

class HistoryList with ChangeNotifier{
  List<Product> myHistoryList = [];

  List<Product> getMyHistoryList(){
    return myHistoryList;
  }

  void addToHistory(productName,productImg,productDetails,productColors,productCategory,productPrice,productSizes,productRating,productCount){
    myHistoryList.insert(0, Product(productName: productName, productImg: productImg, productDetails: productDetails, productCategory: productCategory, productColors: productColors, productPrice: productPrice, productSizes: productSizes, productRating: productRating, productCount: productCount));
    notifyListeners();
  }
  void clearHistory(){
    myHistoryList.removeRange(0, myHistoryList.length);
    notifyListeners();
  }
}