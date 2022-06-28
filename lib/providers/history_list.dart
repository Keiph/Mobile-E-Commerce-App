import 'package:boogle_mobile/models/product.dart';
import 'package:flutter/material.dart';

class HistoryList with ChangeNotifier {
  /// Creates a list of [Product] as [myHistoryList]
  List<Product> myHistoryList = [];

  /// return the list of [Product] of [myHistoryList]
  List<Product> getMyHistoryList() {
    return myHistoryList;
  }

  /// add the a new Object to [myHistoryList]
  void addToHistory(
    productName,
    productImg,
    productDetails,
    productColors,
    productCategory,
    productPrice,
    productSizes,
    productRating,
    productCount,
  ) {
    myHistoryList.insert(
      0,
      Product(
        productName: productName,
        productImg: productImg,
        productDetails: productDetails,
        productCategory: productCategory,
        productColors: productColors,
        productPrice: productPrice,
        productSizes: productSizes,
        productRating: productRating,
        productCount: productCount,
      ),
    );
    //Call all registered Listeners from this class, and calls the method "notifyListener()" in ChangeNotifier class
    notifyListeners();
  }

  /// remove all objects in [myHistoryList]
  void clearHistory() {
    myHistoryList.removeRange(0, myHistoryList.length);
    //Call all registered Listeners from this class, and calls the method "notifyListener()" in ChangeNotifier class
    notifyListeners();
  }
}
