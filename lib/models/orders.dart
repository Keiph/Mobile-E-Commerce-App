import 'package:boogle_mobile/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  String id, address1, paidBy;
  int postalCode, totalItem;
  double amount;
  DateTime purchasedBy;
  DateTime deliveryDate;

  Orders(
      {required this.id,
      required this.postalCode,
        required this.totalItem,
      required this.address1,
      required this.paidBy,
      required this.amount,
      required this.purchasedBy,
      required this.deliveryDate});

  Orders.fromMap(Map<String, dynamic> snapshot, String id)
      : id = id,
        postalCode = snapshot['postalCode'] ?? 000000,
        totalItem = snapshot['totalItem'] ?? 0,
        address1 = snapshot['address1'] ?? '',
        paidBy = snapshot['paidBy'] ?? '',
        amount = snapshot['amount'] ?? 0,
        purchasedBy = (snapshot['purchasedBy'] ?? Timestamp.now()).toDate(),
        deliveryDate = (snapshot['deliveryDate'] ?? Timestamp.now()).toDate();
}
