import 'package:flutter/material.dart';

class MediumTwo extends StatefulWidget {
  const MediumTwo({super.key});

  @override
  State<MediumTwo> createState() => _MediumTwoState();
}

class _MediumTwoState extends State<MediumTwo> {
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 2),
              child: const Text("Press Me"),
            ),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 3),
              child: const Text("Press Me"),
            ),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 4),
              child: const Text("Press Me"),
            ),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 5),
              child: const Text("Press Me"),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    opacity = 0;
                  });
                },
                child: const Text("Press Me")),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    opacity = 1;
                  });
                },
                child: const Text("Reset"))
          ],
        ),
      ),
    );
  }
}
