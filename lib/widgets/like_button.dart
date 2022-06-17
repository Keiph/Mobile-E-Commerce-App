
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/liked_list.dart';

class LikeButton extends StatefulWidget {
  LikeButton(selectedProduct);


  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;



  @override
  Widget build(BuildContext context) {



    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white
      ),

      child: IconButton(
        icon: isLiked
            ? Icon(CupertinoIcons.heart_fill)
            : Icon(CupertinoIcons.heart),
        onPressed: () { setState(() {
          isLiked =!isLiked ;

          if(isLiked){

          }
        }); },
      ),
    );
  }
}
