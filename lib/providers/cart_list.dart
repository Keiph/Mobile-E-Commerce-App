import 'package:flutter/material.dart';

import '../models/product.dart';

class CartList with ChangeNotifier{

  List<Product> myCartList =[];

  List<Product> getMyCartList(){
    return myCartList;
  }

  void addToCart(productName,productImg,productDetails,productColors,productCategory,productPrice,productSizes,productRating,productCount){
    myCartList.insert(0, Product(productName: productName, productImg: productImg, productDetails: productDetails, productCategory: productCategory, productColors: productColors, productPrice: productPrice, productSizes: productSizes, productRating: productRating, productCount: productCount));
    notifyListeners();
  }
  void removeFromCart(i){
    myCartList.removeAt(i);
    notifyListeners();
  }
  void clearCartUponCompletion(){
    myCartList.removeRange(0, myCartList.length);
    notifyListeners();
  }

  double getTotalAmount() {
    double sum = 0;
    myCartList.forEach((element) {
      sum += element.productPrice * element.productCount;
    });
    return sum;
  }
  int getTotalItems(){
    // myCartList.length = int sum to get "UNIQUE" items
    int sum = 0;
    myCartList.forEach((element) {
      sum += element.productCount;

    });
    return sum;
  }

}