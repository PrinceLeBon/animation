import 'package:flutter/material.dart';

class EasyThree extends StatefulWidget {
  const EasyThree({super.key});

  @override
  State<EasyThree> createState() => _EasyThreeState();
}

class _EasyThreeState extends State<EasyThree> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
                style: TextStyle(fontSize: pressed ? 25 : 13),
                duration: const Duration(seconds: 3),
                child: const Text("Observe")),
            Container(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    pressed = true;
                  });
                },
                child: const Text("Change FontSize")),
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
