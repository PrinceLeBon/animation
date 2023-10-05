import 'package:flutter/material.dart';
import 'dart:math' as math;

class Exemple6 extends StatefulWidget {
  const Exemple6({super.key});

  @override
  State<Exemple6> createState() => _Exemple6State();
}

class _Exemple6State extends State<Exemple6> with TickerProviderStateMixin {
  late AnimationController rotationController;
  late Animation<double> rotationAnimation;

  late AnimationController radiusController;
  late Animation<double> radiusAnimation;

  @override
  void initState() {
    super.initState();

    rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    rotationAnimation =
        Tween(begin: -math.pi, end: math.pi).animate(rotationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rotationController.repeat();
            } else if (status == AnimationStatus.dismissed) {
              rotationController.forward();
            }
          });

    radiusController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    radiusAnimation = Tween(begin: 0.0, end: 200.0).animate(radiusController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          radiusController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          radiusController.forward();
        }
      });

    radiusController.forward();
    rotationController.forward();
  }

  @override
  void dispose() {
    radiusController.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            rotationController,
            radiusController,
          ]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(rotationAnimation.value)
                ..rotateY(rotationAnimation.value)
                ..rotateZ(rotationAnimation.value),
              child: CustomPaint(
                painter: PolygonPainter(
                    rotationAnimation.value, radiusAnimation.value),
                child: Container(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PolygonPainter extends CustomPainter {
  final double radians;
  final double radius;

  const PolygonPainter(this.radians, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();

    var angle = (math.pi * 2) / 8;

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint =
        Offset(radius * math.cos(radians), radius * math.sin(radians));

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (int i = 1; i <= 8; i++) {
      double x = radius * math.cos(radians + angle * i) + center.dx;
      double y = radius * math.sin(radians + angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
    //canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
