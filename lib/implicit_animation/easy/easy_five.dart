import 'package:flutter/material.dart';
import 'dart:math' show pi;

class EasyFive extends StatefulWidget {
  const EasyFive({super.key});

  @override
  State<EasyFive> createState() => _EasyFiveState();
}

class _EasyFiveState extends State<EasyFive> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedRotation(
                turns: pressed ? 1 / 8 : 0,
                duration: const Duration(seconds: 1),
                child: Container(
                  color: Colors.blueGrey,
                  width: 200,
                  height: 200,
                )),
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
