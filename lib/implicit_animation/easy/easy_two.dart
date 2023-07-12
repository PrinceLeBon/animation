import 'package:flutter/material.dart';

class EasyTwo extends StatefulWidget {
  const EasyTwo({super.key});

  @override
  State<EasyTwo> createState() => _EasyTwoState();
}

class _EasyTwoState extends State<EasyTwo> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    top: pressed ? 120 : 5,
                    left: pressed ? 120 : 5,
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
