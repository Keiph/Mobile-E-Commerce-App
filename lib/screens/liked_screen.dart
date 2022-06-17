import 'package:boogle_mobile/providers/liked_list.dart';
import 'package:boogle_mobile/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class LikedScreen extends StatefulWidget {

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {

  @override
  Widget build(BuildContext context) {
    LikedList allLikedProduct = Provider.of<LikedList>(context);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Product likedProduct = allLikedProduct.getMyLikedList()[index];
        return ListTile(
          leading: CircleAvatar(child: Image.network(likedProduct.productImg)),
          title: Text(likedProduct.productName),
          subtitle: Text('${likedProduct.productPrice}'),
        );

      },
      itemCount: allLikedProduct.getMyLikedList().length,

    );

  }
}

