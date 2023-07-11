import 'package:flutter/material.dart';
import 'dart:math' show pi;

class DifficultFive extends StatefulWidget {
  const DifficultFive({super.key});

  @override
  State<DifficultFive> createState() => _DifficultFiveState();
}

class _DifficultFiveState extends State<DifficultFive> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pressed
                ? TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: pi),
                    duration: const Duration(seconds: 3),
                    builder: (_, distance, ___) {
                      return Transform(
                        transform: Matrix4.identity()..rotateY(distance),
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 3),
                          width: 200,
                          height: 200,
                          color: Colors.purple,
                          child: Center(
                            child: Text(
                              (distance > pi / 2)
                                  ? "2atad".split('').reversed.join()
                                  : "data1",
                            ),
                          ),
                        ),
                      );
                    })
                : Container(
                    width: 200,
                    height: 200,
                    color: Colors.purple,
                    child: const Center(child: Text("data1")),
                  )

            /*AnimatedRotation(
                turns: pressed ? 1 / 8 : 0,
                duration: const Duration(seconds: 1),
                child: Container(
                  color: Colors.blueGrey,
                  width: 200,
                  height: 200,
                ))*/
            ,
            Container(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    pressed = true;
                  });
                },
                child: const Text("Rotation")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    pressed = false;
                  });
                },
                child: const Text("Reset")),
          ],
        ),
      ),
    );
  }
}
