import 'package:boogle_mobile/providers/product_list.dart';
import 'package:boogle_mobile/screens/login_screen.dart';
import 'package:boogle_mobile/screens/search_screen.dart';
import 'package:boogle_mobile/widgets/carousel_slider.dart';

import 'package:boogle_mobile/widgets/search_gridview_builder.dart';
import 'package:boogle_mobile/widgets/popular_gridview_builder.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';


class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int activeCategory = 1;

  HomeCategory(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this.activeCategory = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15.0),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
            text,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: (index == activeCategory) ? Colors.white : Colors.black)
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: (index == activeCategory) ? Colors.grey[700] : Colors.grey[200],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(
              vertical: size.height *0.1, horizontal: size.width *0.05),
          child: Column(
            children: [
              Row(
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
              SizedBox(
                height: 30,
              ),
              CarouselAutoSlider(),
              SizedBox(
                height: 30,
              ),
              Row(
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
                    /*
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(SearchScreen.routeName);
                      },
                      child: Text(
                        'See all >',
                        style: TextStyle(color: Colors.black),
                      ),
                    )*/
                  ]),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HomeCategory('All', 1),
                      HomeCategory('Shoes', 2),
                      HomeCategory('Clothes', 3),
                      HomeCategory('Computer & Games', 4),
                      HomeCategory('Grocery', 5),
                      HomeCategory('Pet Supplies', 6),
                    ],
                  ),
                ),
              SizedBox(
                height: 30,
              ),

              AspectRatio(
                aspectRatio: 0.65,
                child: PopularGridViewBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
