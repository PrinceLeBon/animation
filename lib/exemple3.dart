import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Exemple3 extends StatefulWidget {
  const Exemple3({super.key});

  @override
  State<Exemple3> createState() => _Exemple3State();
}

const widthAndHeight = 100.0;

class _Exemple3State extends State<Exemple3> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();

    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _xController,
                _yController,
                _zController,
              ]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xController))
                    ..rotateY(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  child: Stack(
                    children: [
                      Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.blue,
                      ),
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-pi / 2),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.red,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX(pi / 2),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.green,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi / 2),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.yellow,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-pi / 2),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.white,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(Vector3(0, 0, -widthAndHeight)),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
