import 'package:flutter/material.dart';
import 'dart:math' as math;

class Visualizer extends StatefulWidget {
  const Visualizer({super.key});

  @override
  State<Visualizer> createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> with TickerProviderStateMixin {
  double radius = 50;
  late AnimationController grandCircleAnimationController,
      smallCircleAnimationController;
  late Animation<double> grandCircleAnimation, smallCircleAnimation;

  @override
  void initState() {
    super.initState();

    grandCircleAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    smallCircleAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    smallCircleAnimation = Tween<double>(begin: -radius, end: radius)
        .animate(smallCircleAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          smallCircleAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          smallCircleAnimationController.forward();
        }
      });

    grandCircleAnimation = Tween<double>(begin: -math.pi, end: math.pi)
        .animate(grandCircleAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          grandCircleAnimationController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          grandCircleAnimationController.forward();
        }
      });

    grandCircleAnimationController.forward();
    smallCircleAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    grandCircleAnimationController.dispose();
    smallCircleAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Visualizer"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AnimatedBuilder(
                  animation: grandCircleAnimation,
                  builder: (context, widget) {
                    return CustomPaint(
                        painter: VisualizerPainter(
                            constRadius: radius,
                            dynamicRadius: smallCircleAnimation.value,
                            radian: grandCircleAnimation.value),
                        child: Container());
                  }),
            ),
            const Text("Radius"),
            Slider(
                value: radius,
                min: 50,
                max: 150,
                onChanged: (value) {
                  setState(() {
                    radius = value;
                    smallCircleAnimation =
                        Tween<double>(begin: -radius, end: radius)
                            .animate(smallCircleAnimationController)
                          ..addStatusListener((status) {
                            if (status == AnimationStatus.completed) {
                              smallCircleAnimationController.reverse();
                            } else if (status == AnimationStatus.dismissed) {
                              smallCircleAnimationController.forward();
                            }
                          });
                  });
                })
          ],
        ));
  }
}

class VisualizerPainter extends CustomPainter {
  final double constRadius;
  final double dynamicRadius;
  final double radian;

  const VisualizerPainter(
      {required this.constRadius,
      required this.dynamicRadius,
      required this.radian});

  @override
  void paint(Canvas canvas, Size size) {
    var bigCircle = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;

    var smallCircle = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = Colors.red;

    var triangle = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = Colors.white;

    var point = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..color = Colors.yellow;

    Offset center = Offset(size.width / 2, size.height / 2);

    Offset startPoint =
        Offset(constRadius * math.cos(radian), constRadius * math.sin(radian));

    Offset centerPoint =
        Offset(startPoint.dx + center.dx, startPoint.dy + center.dy);

    var path1 = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..lineTo(startPoint.dx + center.dx, startPoint.dy + center.dy)
      ..lineTo(size.width / 2 + dynamicRadius, size.height / 2)
      ..close();

    TextPainter(
        text: TextSpan(
            text: "(${centerPoint.dx.toInt()},${centerPoint.dy.toInt()})"),
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: 100)
      ..paint(canvas, centerPoint);

    canvas.drawCircle(center, constRadius, bigCircle);
    canvas.drawCircle(center, dynamicRadius.abs(), smallCircle);
    canvas.drawCircle(centerPoint, 5, point);
    canvas.drawPath(path1, triangle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
