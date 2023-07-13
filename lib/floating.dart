import 'package:flutter/material.dart';

class Floating extends StatefulWidget {
  const Floating({super.key});

  @override
  State<Floating> createState() => _FloatingState();
}

class _FloatingState extends State<Floating> with TickerProviderStateMixin {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedSwitcher(
        switchInCurve: Curves.easeInCubic,
        duration: const Duration(milliseconds: 500),
        child: tapped
            ? SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            tapped = false;
                          });
                        },
                        backgroundColor: Colors.green,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            tapped = false;
                          });
                        },
                        backgroundColor: Colors.yellow,
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 80,
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            tapped = false;
                          });
                        },
                        backgroundColor: Colors.red,
                        child: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 10,
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            tapped = false;
                          });
                        },
                        backgroundColor: Colors.purple,
                        child: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : FloatingActionButton(
                onPressed: () {
                  setState(() {
                    tapped = true;
                  });
                },
                child: const Icon(
                  Icons.open_in_full,
                  color: Colors.black,
                ),
              ),
      ),
    );
  }
}
