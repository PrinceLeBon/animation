import 'package:flutter/material.dart';

class EasyOne extends StatefulWidget {
  const EasyOne({super.key});

  @override
  State<EasyOne> createState() => _EasyOneState();
}

class _EasyOneState extends State<EasyOne> {
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
              duration: const Duration(seconds: 3),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      opacity = 0;
                    });
                  },
                  child: const Text("Press Me")),
            ),
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
