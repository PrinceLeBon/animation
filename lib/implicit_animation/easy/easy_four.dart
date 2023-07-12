import 'package:flutter/material.dart';

class EasyFour extends StatefulWidget {
  const EasyFour({super.key});

  @override
  State<EasyFour> createState() => _EasyFourState();
}

class _EasyFourState extends State<EasyFour> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 3),
              color: pressed ? Colors.red : Colors.blueGrey,
              width: 200,
              height: 200,
            ),
            Container(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    pressed = true;
                  });
                },
                child: const Text("Change color")),
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
