import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Align(alignment:Alignment.bottomCenter,child: Text('Oh No!',style: TextStyle(fontSize: 32, fontWeight:FontWeight.bold, ),))),
        Expanded(flex:3,child:Image.asset('images/pngfind.com-cart-png-2727925.png')),
        Expanded(flex:2,child:Text('You have not add \nany items into cart yet!',textAlign: TextAlign.center,style: TextStyle(fontSize: 18, fontWeight:FontWeight.w600, ),)),
      ],
    );
  }
}
