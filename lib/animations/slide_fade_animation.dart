import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SlideFadeAnimation extends StatelessWidget {

  final Widget child;
  final int position;

  SlideFadeAnimation({required this.child, required this.position});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        //TODO: heads up for part 3, calling of images will require other methods of implementing animation as we will need to implement circular progress indicator
        //TODO: OR we can call this function after we checked that all images has been fetched and ready to load on screen
        duration: const Duration(seconds: 2),
        position: position, // no usage of list here this has 0 impact
        child: SlideAnimation(
          verticalOffset: 30.0,
          child: FadeInAnimation(
            child: child,
          ),
        ),
      ),
    );
  }
}
