import 'package:boogle_mobile/animations/slide_fade_animation.dart';
import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/models/users.dart';
import 'package:boogle_mobile/services/auth_service.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:boogle_mobile/widgets/carousel_slider.dart';

import 'package:boogle_mobile/widgets/popular_gridview_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:boogle_mobile/main.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //initialise activeCategory = 1
  int activeCategory = 1;

  /// [homeCategory] is a helper method that generates the following return Widget wherever this method is called under the Build Method
  /// of [HomeScreen]. [text] and [index] are required arguments wherever this helper method is called.
  /// [text] holds a String literals that determines the category of product displayed on screen.
  /// [index] uniquely holds integer value to change (setState} the UI of the widgets in respond with the return
  /// of [GestureDetector]. In the event, there are multiple same values of index, the UI of all widgets that correspond
  /// with the index value will change as well.
  GestureDetector homeCategory(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          //set value of activeCategory to the value of the passed argument index
          activeCategory = index;
        });
      },

      // Widget UI of Helper method
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15.0),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            // if it is selected change text color to white else black
            color: (index == activeCategory) ? Colors.white : Colors.black,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          // if it is selected change box decoration color to darker shade of grey else lighter shade of grey
          color: index == activeCategory ? Colors.grey[700] : Colors.grey[200],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FirestoreService fsService = FirestoreService();


        return StreamBuilder<FirestoreUser>(
            stream: fsService.getAuthUserFromFirestore(),
            builder: (context, snapshotUsers) {

              return snapshotUsers.connectionState == ConnectionState.waiting ?
              Center(child: CircularProgressIndicator()) :
                  snapshotUsers.hasData ?
              Scaffold(
                body: SingleChildScrollView(
                  child: SafeArea(
                    minimum: EdgeInsets.symmetric(
                      vertical: size.height * 0.1,
                      horizontal: size.width * 0.05,
                    ),
                    child: Column(
                      children: [
                        //Onboard Message + Notification
                        SlideFadeAnimation(
                          position: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Hello ' + snapshotUsers.data!.userName + '!',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyleConst.kLargeBold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: MyApp.themeNotifier.value ==
                                      ThemeMode.light
                                      ? Colors.white
                                      : Colors.black,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: MyApp.themeNotifier.value ==
                                        ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                child: const Icon(Icons.notifications),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        //Carousel Slider
                        const SlideFadeAnimation(
                          position: 2,
                          // Calls Widget Class
                          child: CarouselAutoSlider(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        //Heading Text
                        SlideFadeAnimation(
                          position: 3,
                          child: Row(
                            children: const [
                              Text(
                                'Popular',
                                style: TextStyleConst.kLargeBold,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //Filter by category Chips
                        SlideFadeAnimation(
                          position: 4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // Calls helper method (homeCategory) to build the Widgets in this format
                                homeCategory('All', 1),
                                homeCategory('Shoes', 2),
                                homeCategory('Clothes', 3),
                                homeCategory('Computer & Games', 4),
                                homeCategory('Grocery', 5),
                                homeCategory('Pet Supplies', 6),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        //GridView Product Cards
                        SlideFadeAnimation(
                          position: 5,
                          child: AspectRatio(
                            aspectRatio: 0.65,
                            child: PopularGridViewBuilder(activeCategory),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ) : Center();
            }
        );
      }}

