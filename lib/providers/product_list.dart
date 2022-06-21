import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductList with ChangeNotifier {

  List<Product> myProductList = [
    Product(productName: "Example 1", productImg: "https://cdn.pixabay.com/photo/2018/07/25/18/36/ecommerce-3562005_960_720.jpg", productDetails: "productDetails", productCategory: "Shoes"  ,productColors: Colors.blue ,productPrice: 200.00 , productSizes: 'Shoes Size', productRating: 0.5, productCount: 1),
    Product(productName: "Example 2222222222222222222222222222222222222222222222222222222222222222222222222222222222", productImg: "https://cdn.pixabay.com/photo/2015/01/02/10/47/search-engine-optimization-586422_960_720.jpg", productDetails: "productDetails222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222", productCategory: "Grocery"  ,productColors: Colors.green ,productPrice: 2.75 , productSizes: 'Grams',productRating: 5.0, productCount: 1),
    Product(productName: "Example 3", productImg: "https://cdn.pixabay.com/photo/2017/10/13/05/26/silk-tie-2846862_960_720.jpg", productDetails: "productDetails3", productCategory: "Clothes"  ,productColors: Colors.white ,productPrice: 12.25 , productSizes: 'XL', productRating: 4.5, productCount: 1),
    Product(productName: "Example 4", productImg: "https://cdn.pixabay.com/photo/2018/07/25/18/36/ecommerce-3562005_960_720.jpg", productDetails: "productDetails4", productCategory: "Pet Supplies"  ,productColors: Colors.brown ,productPrice: 50.00 , productSizes: 'Metres', productRating: 2.0, productCount: 1),
    Product(productName: "Example 5", productImg: "https://cdn.pixabay.com/photo/2015/01/02/10/47/search-engine-optimization-586422_960_720.jpg", productDetails: "productDetails5", productCategory: "Computer & Games"  ,productColors: Colors.red ,productPrice: 24.00, productSizes: 'Metres',productRating: 1.0, productCount: 1),
    Product(productName: "Example 6", productImg: "https://cdn.pixabay.com/photo/2018/07/25/18/36/ecommerce-3562005_960_720.jpg", productDetails: "productDetails", productCategory: "Shoes"  ,productColors: Colors.blue ,productPrice: 200.00 , productSizes: 'Shoes Size',productRating: 1.0, productCount: 1),
    Product(productName: "Example 7", productImg: "https://cdn.pixabay.com/photo/2015/01/02/10/47/search-engine-optimization-586422_960_720.jpg", productDetails: "productDetails2", productCategory: "Grocery"  ,productColors: Colors.black ,productPrice: 2.75 , productSizes: 'Grams',productRating: 4.0, productCount: 1),
    Product(productName: "Example 8", productImg: "https://cdn.pixabay.com/photo/2017/10/13/05/26/silk-tie-2846862_960_720.jpg", productDetails: "productDetails3", productCategory: "Clothes"  ,productColors: Colors.white ,productPrice: 12.25 , productSizes: 'XL',productRating: 2.0, productCount: 1),
    Product(productName: "Example 9", productImg: "https://cdn.pixabay.com/photo/2018/07/25/18/36/ecommerce-3562005_960_720.jpg", productDetails: "productDetails4", productCategory: "Pet Supplies"  ,productColors: Colors.brown ,productPrice: 50.00 , productSizes: 'Metres',productRating: 0.0, productCount: 1),
    Product(productName: "Example 10", productImg: "https://cdn.pixabay.com/photo/2015/01/02/10/47/search-engine-optimization-586422_960_720.jpg", productDetails: "productDetails5", productCategory: "Computer & Games"  ,productColors: Colors.red ,productPrice: 24.00 , productSizes: 'Metres',productRating: 5.0, productCount: 1),

  ];





  List<Product> getAllProductList(){
    return myProductList;
  }

  List<Product> getPopularProduct(){
    List<Product> temp = List.from(myProductList);
    temp.sort((a,b) => b.productRating.compareTo(a.productRating));
    return temp;
  }
  void addProduct(productName,productImg,productDetails,productColors,productCategory,productPrice,productSizes,productRating,productCount){
    myProductList.insert(0, Product(productName: productName, productImg: productImg, productDetails: productDetails, productCategory: productCategory, productColors: productColors, productPrice: productPrice, productSizes: productSizes, productRating: productRating, productCount: productCount));
    notifyListeners();
  }

  void deleteProduct(i){
    myProductList.removeAt(i);
    notifyListeners();
  }




}
