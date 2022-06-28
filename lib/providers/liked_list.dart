import 'package:boogle_mobile/models/product.dart';
import 'package:flutter/material.dart';

class LikedList with ChangeNotifier {
  /// Creates a list of [Product] as [myLikedList]
  List<Product> myLikedList = [];

  /// return the list of [Product] of [myLikedList]
  List<Product> getMyLikedList() {
    return myLikedList;
  }

  /// add the a new Object to [myLikedList]
  void addToLiked(
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
    myLikedList.insert(
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

  /// remove an existing Object from [myLikedList] based on [i] (index in [myLikedList])
  void removeFromLiked(i) {
    myLikedList.removeAt(i);
    //Call all registered Listeners from this class, and calls the method "notifyListener()" in ChangeNotifier class
    notifyListeners();
  }
}
