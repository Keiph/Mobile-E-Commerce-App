
import 'package:boogle_mobile/providers/product_list.dart';
import 'package:boogle_mobile/screens/login_screen.dart';
import 'package:boogle_mobile/widgets/carousel_slider.dart';
import 'package:boogle_mobile/widgets/search_gridview_builder.dart';
import 'package:boogle_mobile/widgets/popular_gridview_builder.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 70.0, bottom: 30.0, left: 20.0,right: 20.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 10/1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hello Keiph!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat')),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Icon(Icons.notifications),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              AspectRatio(
                aspectRatio: 16/9,
                child: CarouselAutoSlider(),
              ),
              SizedBox(
                height: 50,
              ),
              AspectRatio(
                aspectRatio: 10/1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Text(
                    'Popular',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () { Navigator.of(context).pushNamed(LoginScreen.routeName);},
                    child: Text('See all >',style: TextStyle(color: Colors.black),),
                  )
                ]),
              ),
              AspectRatio(
                aspectRatio: 5/1,
                  child: Row(
                    children: [Text('Hello'),

                    ],
                  ),
              ),
              AspectRatio(
                aspectRatio: 0.95,
                child: PopularGridViewBuilder(),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
