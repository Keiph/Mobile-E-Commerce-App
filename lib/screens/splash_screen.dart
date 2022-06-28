import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:boogle_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 4000,
      splash: Container(
        padding: const EdgeInsets.all(0.0),
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
                'images/ruchindra-gunasekara-GK8x_XCcDZg-unsplash.jpg',),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart,
              size: 150,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'B',
                    style: TextStyle(
                      fontFamily: 'Harman',
                      fontWeight: FontWeight.bold,
                      fontSize: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                    indent: 5,
                    endIndent: 0,
                    width: 30,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Boogle',
                    style: TextStyle(
                      fontFamily: 'Harman',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      nextScreen: const MainScreen(),
      splashIconSize: double.maxFinite,
      centered: true,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
