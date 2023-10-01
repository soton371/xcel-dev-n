import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTrackTween([
    //   Track("opacity")
    //       .add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       const Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);

    final tween = MovieTween()
    ..tween("opacity", Tween(begin: 0.0, end: 1.0),duration: const Duration(milliseconds: 500))
    ..tween("translateY", Tween(begin: -30.0, end: 0.0),duration: const Duration(milliseconds: 500),curve: Curves.easeOut);

    return PlayAnimationBuilder(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, move, animation) {
        if (animation != null) {
          return child;
        } else {
          return const SizedBox();
        }
      }
    );
  }
}
