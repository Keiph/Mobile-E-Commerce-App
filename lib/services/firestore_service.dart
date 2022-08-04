import 'package:boogle_mobile/models/orders.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/models/users.dart';
import 'package:boogle_mobile/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  AuthService authService = AuthService();
  //Create
  addProduct(productName, productImg, productDetails, productCategory,productColors, productPrice, productSizes, productRating, productCount) {
    return FirebaseFirestore.instance
        .collection('products')
        .add({'ownerEmail':authService.getCurrentUser()!.email,'productName': productName, 'productImg': productImg, 'productDetails': productDetails, 'productCategory': productCategory,'productColors': productColors, 'productPrice': productPrice, 'productSizes': productSizes, 'productRating': productRating, 'productCount': productCount});
  }

  Future<void> addUser(email, userName,phoneNo){
    return FirebaseFirestore.instance
        .collection('users')
        .doc(email.toString().toLowerCase())
        .set({'userName': userName, 'phoneNo': phoneNo});
  }

  addToCart(ownerEmail,productName, productImg, productColors,productPrice,productSizes,productRating,productCount){
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .collection('users-cart-items')
        .add({'ownerEmail': ownerEmail, 'productName':productName, 'productImg':productImg, 'productColors':productColors, 'productPrice':productPrice,'productSizes':productSizes,'productRating':productRating,'productCount':productCount});
  }

  addToLiked(ownerEmail,productCategory,productName, productImg, productColors,productPrice,productSizes,productRating,productCount){
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .collection('users-liked-items')
        .add({'ownerEmail': ownerEmail,'productCategory': productCategory, 'productName':productName, 'productImg':productImg, 'productColors':productColors, 'productPrice':productPrice,'productSizes':productSizes,'productRating':productRating,'productCount':productCount});
  }

  addToOrder(postalCode, address1, paidBy, amount, totalItem, purchasedBy, deliveryDate){
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .collection('users-orders-history')
        .add({'postalCode': postalCode, 'address1': address1, 'paidBy': paidBy, 'amount':amount, 'totalItem': totalItem, 'purchasedBy':purchasedBy, 'deliveryDate': deliveryDate});
  }

  //Delete
  removeProduct(id) {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .delete();
  }

  removeFromCart(id){
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .collection('users-cart-items')
        .doc(id)
        .delete();
  }

  removeFromLiked(id){
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .collection('users-liked-items')
        .doc(id)
        .delete();
  }

  //Read
  Stream<List<Product>> getProducts() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map<Product>((doc) => Product.fromMap(doc.data(), doc.id))
        .toList());
  }

  Stream<List<Orders>> getUsersOrders() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .collection('users-orders-history')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map<Orders>((doc) => Orders.fromMap(doc.data(), doc.id))
        .toList(),);
  }

  Stream<List<Product>> getProductsByRating() {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('productRating',descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map<Product>((doc) => Product.fromMap(doc.data(), doc.id))
        .toList());
  }

  Stream<List<Product>> getProductsByCategory(categoryName) {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('productRating',descending: true)
        .where('productCategory', isEqualTo:categoryName)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map<Product>((doc) => Product.fromMap(doc.data(), doc.id))
        .toList());
  }

  Stream<List<Product>> getProductsByText(searchInput) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('productName', isEqualTo: searchInput )
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map<Product>((doc) => Product.fromMap(doc.data(), doc.id))
        .toList());
  }

  Stream<List<Product>> getUserCartItems() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .collection('users-cart-items')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map<Product>((doc) => Product.fromMap(doc.data(), doc.id))
        .toList());
  }

  Stream<List<Product>> getUserLikedItems() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .collection('users-liked-items')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map<Product>((doc) => Product.fromMap(doc.data(), doc.id))
        .toList());
  }




Stream<FirestoreUser> getAuthUserFromFirestore(){
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .snapshots()
        .map<FirestoreUser>((doc) => FirestoreUser.fromMap(doc.data()));
  }



  //Update
  editProduct(id, productName, productImg, productDetails, productCategory,productColors, productPrice, productSizes, productRating, productCount) {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .set({'productName': productName, 'productImg': productImg, 'productDetails': productDetails, 'productCategory': productCategory,'productColors': productColors, 'productPrice': productPrice, 'productSizes': productSizes, 'productRating': productRating, 'productCount': productCount});
  }

  increaseCartProductCount(id, productCount){
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authService.getCurrentUser()!.email)
        .collection('users-cart-items')
        .doc(id)
        .update({'productCount': productCount + 1});
  }


}