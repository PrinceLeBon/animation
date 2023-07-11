import 'package:flutter/material.dart';

class MediumThree extends StatefulWidget {
  const MediumThree({super.key});

  @override
  State<MediumThree> createState() => _MediumThreeState();
}

class _MediumThreeState extends State<MediumThree> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(seconds: 3),
                    curve: Curves.bounceOut,
                    top: pressed ? 120 : 5,
                    left: 62.5,
                    child: Container(
                      width: 75,
                      height: 75,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    pressed = true;
                  });
                },
                child: const Text("Move")),
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
