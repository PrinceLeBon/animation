import 'package:flutter/material.dart';

class StagerredAnimation extends StatefulWidget {
  const StagerredAnimation({super.key});

  @override
  State<StagerredAnimation> createState() => _StagerredAnimationState();
}

class _StagerredAnimationState extends State<StagerredAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> width;
  late Animation<double> height;
  late Animation<EdgeInsets> padding;
  late Animation<BorderRadius?> borderRadius;
  late Animation<Color?> color;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: controller, curve: const Interval(0, 0.1, curve: Curves.ease)));

    width = Tween<double>(
      begin: 50,
      end: 200,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.125, 0.250, curve: Curves.ease)));

    height = Tween<double>(
      begin: 25,
      end: 100,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.250, 0.375, curve: Curves.ease)));

    padding = EdgeInsetsTween(
            begin: const EdgeInsets.only(bottom: 10),
            end: const EdgeInsets.only(bottom: 50))
        .animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.250, 0.375, curve: Curves.ease)));

    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(4),
      end: BorderRadius.circular(75),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.375,
          0.500,
          curve: Curves.ease,
        ),
      ),
    );
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.500, 0.750, curve: Curves.ease)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _playAnimation,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Container(
                  padding: padding.value,
                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                    opacity: opacity.value,
                    child: Container(
                      width: width.value,
                      height: height.value,
                      decoration: BoxDecoration(
                        color: color.value,
                        border: Border.all(
                          color: Colors.indigo,
                          width: 3.0,
                        ),
                        borderRadius: borderRadius.value,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _playAnimation() async {
    try {
      await controller.forward().orCancel;
      await controller.reverse().orCancel;
    } on TickerCanceled {}
  }
}
