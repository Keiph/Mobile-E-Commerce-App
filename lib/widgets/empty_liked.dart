import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyLiked extends StatelessWidget {
  const EmptyLiked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'No Favourites\nShown',
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
