import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselAutoSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2017/10/13/05/26/silk-tie-2846862_960_720.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2015/01/02/10/47/search-engine-optimization-586422_960_720.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2018/07/25/18/36/ecommerce-3562005_960_720.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,
        enableInfiniteScroll: true,

      ),
    );
  }
}
