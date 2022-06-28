import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SlideFadeAnimation extends StatelessWidget {
  final Widget child;
  final int position;

  /// The [child] and the [position] must not be null

  const SlideFadeAnimation({
    required this.child,
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      // To be effective AnimationLimiter is created as an Inherited Widget that allow classes to extend the information anywhere under the widget tree
      child: AnimationConfiguration.staggeredList(
        //TODO:heads up for part 3, calling of images will require other methods of implementing animation as we will need to implement circular progress indicator OR we can call this function after we checked that all images has been fetched and ready to load on screen
        duration: const Duration(seconds: 2),
        position: position,
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
