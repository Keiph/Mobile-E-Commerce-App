import 'package:boogle_mobile/models/product.dart';
import 'package:flutter/material.dart';

class CartList with ChangeNotifier {
  /// Creates a list of [Product] as [myCartList]
  List<Product> myCartList = [];

  /// return the list of [Product] of [myCartList]
  List<Product> getMyCartList() {
    return myCartList;
  }

  /// add the a new Object to [myCartList]
  void addToCart(
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
    myCartList.insert(
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

  /// remove an existing Object from [myCartList] based on [i] (index in [myCartList])
  void removeFromCart(i) {
    myCartList.removeAt(i);
    //Call all registered Listeners from this class, and calls the method "notifyListener()" in ChangeNotifier class
    notifyListeners();
  }

  /// remove all objects in [myCartList]
  void clearCartUponCompletion() {
    myCartList.removeRange(0, myCartList.length);
    //Call all registered Listeners from this class, and calls the method "notifyListener()" in ChangeNotifier class
    notifyListeners();
  }

  /// loop in [myCartList] for every element in list returns the total amount
  double getTotalAmount() {
    double sum = 0;
    for (var element in myCartList) {
      sum += element.productPrice * element.productCount;
    }
    return sum;
  }

  /// loop in [myCartList] for every element in list return the total items
  int getTotalItems() {
    // myCartList.length = int sum to get "UNIQUE" items
    int sum = 0;
    for (var element in myCartList) {
      sum += element.productCount;
    }
    return sum;
  }
}
