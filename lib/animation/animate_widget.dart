import 'package:flutter/material.dart';

class AnimateWidget extends StatefulWidget {
  final int seconds;
  final Widget? child;
  final double beginSize;
  final double endSize;
  const AnimateWidget(
      {super.key, this.seconds = 3,
      this.child,
      this.beginSize = 50.0,
      this.endSize = 100.0});

  @override
  AnimateWidgetState createState() => AnimateWidgetState();
}

class AnimateWidgetState extends State<AnimateWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _sizeAnimation;

  bool reverse = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.seconds))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.repeat(reverse: !reverse);
          reverse = !reverse;
        }
      });

    _sizeAnimation = Tween<double>(begin: widget.beginSize, end: widget.endSize)
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sizeAnimation,
      builder: (context, child) => SizedBox(
        width: _sizeAnimation.value,
        height: _sizeAnimation.value,
        child: widget.child,
      ),
    );
  }
}
