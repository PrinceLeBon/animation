import 'package:flutter/material.dart';

class MediumOne extends StatefulWidget {
  const MediumOne({super.key});

  @override
  State<MediumOne> createState() => _MediumOneState();
}

class _MediumOneState extends State<MediumOne> {
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
