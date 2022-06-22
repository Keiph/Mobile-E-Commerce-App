import 'package:boogle_mobile/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyLiked extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('No Favourites\nShown',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}
