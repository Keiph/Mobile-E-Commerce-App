import 'package:boogle_mobile/widgets/search_gridview_builder.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
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
              ),
              Expanded(
                child: Text('Search:' + 'Hello', style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ), ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(48.0),

                  ),
                  child: SearchGridViewBuilder(),

              ),),
            ],
          ),
        ),
      ),
    );
  }
}
