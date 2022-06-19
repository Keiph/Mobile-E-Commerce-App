import 'package:flutter/material.dart';

class EmptyLiked extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No Favourites Shown',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32
          ),),
        ],
      ),
    );
  }
}
