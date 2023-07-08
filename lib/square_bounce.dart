import 'package:flutter/material.dart';

class SquareBounced extends StatefulWidget {
  const SquareBounced({super.key});

  @override
  State<SquareBounced> createState() => _SquareBouncedState();
}

class _SquareBouncedState extends State<SquareBounced>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animation = Tween<double>(begin: 50, end: 300)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        }
      });
    colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animation,
        builder: (context, widget) {
          return Center(
            child: Container(
              width: animation.value,
              height: animation.value,
              color: colorAnimation.value,
            ),
          );
        },
      ),
    );
  }
}
