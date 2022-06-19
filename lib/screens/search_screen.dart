import 'package:boogle_mobile/widgets/search_gridview_builder.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: size.height *0.1, horizontal: size.width *0.05),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30, 20.0),
                  hintText: "Search",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Search:' + '', style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              ),
              SizedBox(
                height: 30,
              ),

              Container(
                width: double.infinity,
                height: size.height *0.55,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(48.0),

                ),
                child: SearchGridViewBuilder(),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
